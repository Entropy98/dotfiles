# Dependencies

## Vim

* [coc-clang](https://github.com/clangd/coc-clangd)
  * [Node](https://nodejs.org/en/)
    * [nvm](https://github.com/nvm-sh/nvm)
* [NerdTree](https://github.com/preservim/nerdtree)
* [NeoVim](https://neovim.io/)
* [Pathogen](https://github.com/tpope/vim-pathogen)
* [Vim-Plug](https://fanwangecon.github.io/Tex4Econ/nontex/install/linux/fn_vim.html)

## i3

* [feh](https://packages.ubuntu.com/search?keywords=feh)
* [i3-workspace-names-daemon](https://github.com/cboddy/i3-workspace-names-daemon)
* [i3blocks](https://github.com/vivien/i3blocks)
* [i3lock](https://i3wm.org/i3lock/)
* [picom](https://github.com/yshui/picom)
* [polybar](https://github.com/polybar/polybar)
* [pulseaudio](https://wiki.ubuntu.com/PulseAudio)
* [rofi](https://github.com/davatorium/rofi)
* Xresources generated with [pic2theme](https://github.com/Entropy98/Pic-to-Theme)

## niri

* [niri](https://github.com/YaLTeR/niri)
* [waybar](https://github.com/Alexays/Waybar) — 0.15.0+, for the native `niri/*` modules
* [jq](https://jqlang.github.io/jq/) — the waybar workspace scripts parse `niri msg --json`
* A [Nerd Font](https://www.nerdfonts.com/) — supplies the per-window icons in the bar

## Terminal
* [kitty](https://sw.kovidgoyal.net/kitty/)

# Usage

## Symbolic links

### i3
* ~/.config/i3/config                         -> <dotfiles>/i3/config
* ~/.config/rofi/config.rasi                  -> <dotfiles>/i3/rofi/config.rasi
* ~/.i3/app-icons.json                        -> <dotfiles>/i3/app-icons.json

### niri
* ~/.config/niri/config.kdl                   -> <dotfiles>/niri/config.kdl
* ~/.config/waybar/config.jsonc               -> <dotfiles>/niri/waybar/config.jsonc
* ~/.config/waybar/style.css                  -> <dotfiles>/niri/waybar/style.css
* ~/.config/waybar/scripts                    -> <dotfiles>/niri/waybar/scripts
* ~/.config/fuzzel/fuzzel.ini                 -> <dotfiles>/niri/fuzzel/fuzzel.ini
* ~/.config/swaylock/config                   -> <dotfiles>/niri/swaylock/config

### Vim
* ~/.config/nvim/autoload/Colorizer.vim       -> <dotfiles>/vim/.vim/autoload/Colorizer.vim
* ~/.config/nvim/autoload/pathogen.vim        -> <dotfiles>/vim/.vim/autoload/pathogen.vim
* ~/.config/nvim/autoload/plug.vim            -> <dotfiles>/vim/.vim/autoload/plug.vim
* ~/.config/nvim/init.vim                     -> <dotfiles>/vim/.vimrc
* ~/.config/nvim/plugin/cscope\_maps.vim      -> <dotfiles>/vim/.vim/plugin/cscope\_maps.vim
* ~/.config/nvim/plugin/ColorizerPlugin.vim   -> <dotfiles>/vim/.vim/plugin/ColorizerPlugin.vim

### Terminal
* ~/.config/kitty/kitty.conf

### Bash
* ~/.bashrc                                   -> <dotfiles>/bash/.bashrc
