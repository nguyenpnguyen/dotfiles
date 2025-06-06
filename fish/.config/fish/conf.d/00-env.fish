set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx XDG_SCREENSHOTS_DIR "$HOME/Pictures/screenshots"

if test -d "$HOME/bin"
    fish_add_path -g "$HOME/bin"
end

if test -d "$HOME/.local/bin"
    fish_add_path -g "$HOME/.local/bin"
end
