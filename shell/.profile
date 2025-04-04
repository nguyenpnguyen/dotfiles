# environment variables:
export XDG_CONFIG_DIR=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1

export TERM='xterm-256color'
export EDITOR='nvim'
export VISUAL='nvim'

alias ff="fastfetch"
alias myip='curl ipinfo.io/ip'

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
export BUN_INSTALL="$HOME/.bun"
PATH=$BUN_INSTALL/bin:$PATH

# Go
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME/go/bin

# Rust
. "$HOME/.cargo/env"
PATH=$PATH:$HOME/.cargo/bin

# Java
export JAVA_HOME=$HOME/.sdkman/candidates/java/current
export JAVA=$JAVA_HOME/bin
# export PATH_TO_FX=/opt/jvm/javafx-sdk-22.0.1
# PATH=$JAVA_HOME/bin:$PATH
PATH=$PATH_TO_FX/lib:$PATH

# Maven
export PATH=$PATH:/opt/maven/apache-maven-3.9.6/bin 

# Lua
export LUAINC=/usr/include/lua5.4/
PATH=$PATH:/usr/local/luarocks/bin
PATH=$PATH:$HOME/.luarocks/bin

# Python
export PATH=$PATH:/opt/anaconda/bin

# Perl
# PATH="/home/nguyen/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/home/nguyen/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/home/nguyen/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/home/nguyen/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/home/nguyen/perl5"; export PERL_MM_OPT;

# Pfetch-rs
export PF_INFO="ascii title os host cpu kernel pkgs de shell editor palette"

# Tex
# MANPATH=$MANPATH:/usr/local/texlive/2024/texmf-dist/doc/man
# INFOPATH=$INFOPATH:/usr/local/texlive/2024/texmf-dist/doc/info
# PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux

# Exercism
# if [ -f ~/.config/exercism/exercism_completion.bash ]; then
#    source ~/.config/exercism/exercism_completion.bash
# fi

export PATH
# export MANPATH
# export INFOPATH

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Zoxide
eval "$(zoxide init bash)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
