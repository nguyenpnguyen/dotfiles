# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# environment variables:
export THEME_DIR=$HOME/.themes
export XDG_CONFIG_DIR=$HOME/.config
export HYPRSHOT_DIR=$HOME/screenshots

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
PATH="$PATH:/usr/bin"
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

# Go
PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go/bin/

# Rust
# . "$HOME/.cargo/env"
PATH=$PATH:$HOME/.cargo/bin

# Java
# JAVA_HOME=/usr/bin/java
# PATH=$PATH:$HOME/bin:$JAVA_HOME/bin  
# export JAVA_HOME  


# Perl
PATH="/home/nguyen/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/nguyen/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/nguyen/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/nguyen/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/nguyen/perl5"; export PERL_MM_OPT;

# Pfetch-rs
export PF_INFO="ascii title os host cpu kernel pkgs de shell editor palette"

export PATH
pfetch
