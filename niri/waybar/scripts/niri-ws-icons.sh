#!/usr/bin/env bash
# Waybar custom module: render one niri workspace as a button labelled with its
# index plus a Nerd Font icon for every window it holds.
#
#   usage: niri-ws-icons.sh <workspace-index>
#
# Prints a single waybar JSON line. Workspaces that don't exist print empty
# text, which waybar hides — so the buttons appear and disappear as niri
# creates and reaps workspaces.
set -euo pipefail

idx="${1:?usage: niri-ws-icons.sh <workspace-index>}"

FOCUSED_COLOR="#a9dc76" # monokai green, matches niri's focus ring
URGENT_COLOR="#ff6188"  # monokai red

# app_id (lowercased) -> Nerd Font glyph. First matching pattern wins, so keep
# specific names above the generic *term* / *files* catch-alls. Glyphs outside
# the BMP are written as \U escapes because they're easy to mangle when editing;
# look codepoints up at nerdfonts.com/cheat-sheet to add your own.
icon_for() {
    case "$1" in
    *alacritty* | *kitty* | *foot* | *wezterm* | *ghostty* | *term*) printf '' ;;  # terminal
    *firefox* | *librewolf* | *zen* | *waterfox*) printf '' ;;                     # firefox
    *chromium* | *chrome* | *brave*) printf '' ;;                                  # chrome
    *code* | *vscodium*) printf '\U000F0A1E' ;;                                          # vscode
    *thunderbird* | *mail*) printf '' ;;                                           # envelope
    *discord* | *vesktop*) printf '\U000F066F' ;;                                        # discord
    *slack*) printf '' ;;                                                          # slack
    *telegram*) printf '' ;;                                                       # telegram
    *signal*) printf '' ;;                                                         # comment
    *sone* | *spotify* | *ncmpcpp* | *music*) printf '' ;;                         # music note
    *steam* | *lutris*) printf '' ;;                                               # steam
    *mpv* | *vlc* | *celluloid*) printf '' ;;                                      # video
    *gimp* | *inkscape* | *krita*) printf '' ;;                                    # paintbrush
    *obsidian* | *zotero*) printf '' ;;                                            # book
    *zathura* | *evince* | *okular* | *papers* | *pdf*) printf '' ;;               # pdf
    *pavucontrol* | *easyeffects* | *helvum*) printf '' ;;                         # speaker
    *nautilus* | *thunar* | *dolphin* | *nemo* | *files*) printf '' ;;             # folder
    *lucid* | *draw* | *figma*) printf '' ;;                                       # image
    *) printf '' ;;                                                                # generic window
    esac
}

# Escape text for pango markup. & must go first or it double-escapes.
pango_escape() {
    local s=$1
    s=${s//&/&amp;}
    s=${s//</&lt;}
    s=${s//>/&gt;}
    printf '%s' "$s"
}

ws_json=$(niri msg --json workspaces)

# niri numbers workspaces per-output, so index 1 exists on every monitor.
# Scope the bar to whichever output currently has focus.
output=$(jq -r '
    (map(select(.is_focused)) | first | .output)
    // (map(select(.is_active)) | first | .output)
    // ""' <<<"$ws_json")

ws=$(jq -c --arg out "$output" --argjson idx "$idx" \
    'map(select(.output == $out and .idx == $idx)) | first // empty' <<<"$ws_json")

if [[ -z $ws ]]; then
    printf '{"text":""}\n'
    exit 0
fi

read -r ws_id ws_focused ws_active ws_urgent ws_name < <(
    jq -r '[.id, (.is_focused|tostring), (.is_active|tostring),
            (.is_urgent|tostring), (.name // "")] | @tsv' <<<"$ws"
)

# Windows on this workspace, left-to-right in niri's scrolling layout.
# Floating windows have a null position; sort them to the end.
mapfile -t wins < <(
    niri msg --json windows | jq -r --argjson wsid "$ws_id" '
        map(select(.workspace_id == $wsid))
        | sort_by(.layout.pos_in_scrolling_layout // [9999, 9999])
        | .[] | [(.app_id // "unknown"), (.is_focused|tostring),
                 (.is_urgent|tostring), (.title // "")] | @tsv'
)

icons=""
tooltip_lines=()
for w in "${wins[@]}"; do
    IFS=$'\t' read -r app_id win_focused win_urgent title <<<"$w"
    icon=$(icon_for "${app_id,,}")

    if [[ $win_urgent == true ]]; then
        icon="<span color=\"$URGENT_COLOR\">$icon</span>"
    elif [[ $win_focused == true ]]; then
        icon="<span color=\"$FOCUSED_COLOR\">$icon</span>"
    fi
    icons+="${icons:+ }$icon"

    marker="  "
    [[ $win_focused == true ]] && marker="▸ "
    tooltip_lines+=("${marker}$(pango_escape "$app_id") — $(pango_escape "${title:0:70}")")
done

label=${ws_name:-$idx}
text="$label${icons:+  $icons}"

classes=()
[[ $ws_focused == true ]] && classes+=("focused")
[[ $ws_active == true ]] && classes+=("active")
[[ $ws_urgent == true ]] && classes+=("urgent")
[[ ${#wins[@]} -eq 0 ]] && classes+=("empty") || classes+=("occupied")

tooltip=$(printf '%s\n' "${tooltip_lines[@]-}")
tooltip=${tooltip%$'\n'}
[[ -z $tooltip ]] && tooltip="workspace $label — empty"

jq -cn --arg text "$text" --arg tooltip "$tooltip" \
    --argjson class "$(printf '%s\n' "${classes[@]}" | jq -R . | jq -sc .)" \
    '{text: $text, tooltip: $tooltip, class: $class}'
