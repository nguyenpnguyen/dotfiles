# environment variables:
export XDG_CONFIG_DIR=$HOME/.config
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1

export TERM='xterm-256color'
export EDITOR='nvim'
export VISUAL='nvim'

set -o vi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
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
export PATH="$PATH:/opt/nvim-linux64/bin"
export EDITOR=nvim

# Nodejs
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/nguyen/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
PATH=$BUN_INSTALL/bin:$PATH

# Go
PATH=$PATH:/usr/local/go/bin
PATH=$GOPATH/bin/:$PATH
export GOPATH=$HOME/go/bin/

# Rust
. "$HOME/.cargo/env"
PATH=$PATH:$HOME/.cargo/bin

# Java
export JAVA_HOME=/opt/jvm/jdk-22.0.1
export JAVA=$JAVA_HOME/bin/java
export PATH_TO_FX=/opt/jvm/javafx-sdk-22.0.1
PATH=$JAVA_HOME/bin:$PATH
PATH=$PATH_TO_FX/lib:$PATH

# Maven
PATH=$PATH:/opt/maven/apache-maven-3.9.6/bin 

# Lua
export LUAINC=/usr/include/lua5.4/

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

# Zoxide
eval "$(zoxide init bash)"

export PATH
export MANPATH
export INFOPATH
