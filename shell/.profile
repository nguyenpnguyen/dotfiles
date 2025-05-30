# environment variables:
export XDG_CONFIG_DIR=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1

export TERM='xterm-256color'
export EDITOR='nvim'
export VISUAL='nvim'

alias ff="fastfetch"
alias myip='curl ipinfo.io/ip'
alias vim="nvim"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
    if [ -t 1 ]; then
	bind -x '"\C-f": tmux-sessionizer'
    fi
fi

# if running zsh 
if [ -n "$ZSH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
    bindkey -s ^F "tmux-sessionizer\n"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Neovim
# PATH="$PATH:/opt/nvim-linux64/bin"

# Nodejs
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/nguyen/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
# export BUN_INSTALL="$HOME/.bun"
# PATH=$BUN_INSTALL/bin:$PATH

# Go
# PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME/go/bin

# Rust
# . "$HOME/.cargo/env"
PATH=$PATH:$HOME/.cargo/bin

# Pfetch-rs
export PF_INFO="ascii title os host cpu kernel pkgs de shell editor palette"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/var/home/nguyen/.lmstudio/bin"
