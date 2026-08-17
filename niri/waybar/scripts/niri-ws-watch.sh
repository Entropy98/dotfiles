#!/usr/bin/env bash
# Waybar custom module (renders nothing): watch niri's event stream and poke
# waybar with SIGRTMIN+8 whenever the workspace/window picture changes, so the
# custom/ws* buttons refresh. Runs as a module rather than a systemd unit so it
# lives and dies with waybar.
set -uo pipefail

SIGNAL=8 # must match "signal" in the custom/ws* modules

# waybar doesn't reap its exec children, so a plain `pkill waybar` would strand
# this script and its event stream. Clear out any instance left over from a
# previous waybar before starting a new one.
for pid in $(pgrep -f 'niri-ws-watch\.sh'); do
    [[ $pid == "$$" || $pid == "$PPID" ]] && continue
    kill "$pid" 2>/dev/null
done

# Deliberately not watching WindowLayoutsChanged: it fires on every resize and
# every column scroll, and never changes what the icons show.
is_relevant() {
    case "$1" in
    '{"WorkspacesChanged'* | '{"WorkspaceActivated'* | '{"WorkspaceUrgencyChanged'* | \
        '{"WindowsChanged'* | '{"WindowOpenedOrChanged'* | '{"WindowClosed'* | \
        '{"WindowFocusChanged'* | '{"WindowUrgencyChanged'*) return 0 ;;
    *) return 1 ;;
    esac
}

stream_pid=""
cleanup() {
    [[ -n $stream_pid ]] && kill "$stream_pid" 2>/dev/null
}
trap 'cleanup; exit 0' EXIT INT TERM

while true; do
    # Read via a redirected process substitution rather than a pipe: it keeps the
    # loop in this shell (so `exit` works) and gives us the stream's pid to kill.
    exec 3< <(niri msg --json event-stream 2>/dev/null)
    stream_pid=$!

    while IFS= read -r -u 3 line; do
        is_relevant "$line" || continue
        # Terminals retitle constantly; drain the burst and refresh once. The
        # icon script re-reads full state anyway, so dropping events loses nothing.
        while IFS= read -r -u 3 -t 0.12 _; do :; done
        # A failed signal means waybar is gone and we're an orphan.
        pkill -RTMIN+"$SIGNAL" waybar || exit 0
    done

    exec 3<&-
    # Stream ended (niri restarted or exited); back off and reconnect.
    sleep 2
done
