if status is-interactive
    # Aliases
    alias ff="fastfetch"
    alias myip="curl ipinfo.io/ip"
    alias vim="nvim"

    # Ctrl-F keybinding
    function fish_user_key_bindings
        fish_vi_key_bindings
        bind \cf run_tmux_sessionizer
        bind -M insert \cf run_tmux_sessionizer
    end

    function run_tmux_sessionizer
        if not type -q tmux-sessionizer
            echo "tmux-sessionizer not found."
            return 1
        end
        tmux-sessionizer
    end

    # y function
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        set cwd (cat -- "$tmp")
        if test -n "$cwd" -a "$cwd" != "$PWD"
            cd "$cwd"
        end
        rm -f -- "$tmp"
    end
end
