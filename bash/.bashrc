# -----------------------------------------------------------------------------
# Basic settings
# -----------------------------------------------------------------------------

shopt -s cdspell
shopt -s cmdhist
shopt -s histappend
shopt -s nocaseglob
shopt -s checkwinsize


# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias ls='ls -F'                       # Display trailing file indicator
alias ll='ls -lh'                      # List in long format
alias llt='ls -ltr'                    # Most recently modified at bottom
alias lg='ls -1 | grep'                # Search for file names in this dir

alias mv='mv -i'                       # Prompts if overriding a file
alias cp='cp -i'                       # Prompts if overriding a file

alias vi='vim'                         # Always use vim, not vi
alias grep='grep --colour=auto'        # Enable color highlighting

alias df='df -h'                       # Human readable figures
alias du='du -h'                       # Human readable figures

alias ..='cd ..'                       # Go back one dir
alias ...='cd ../..'                   # Go back two dirs

alias path='echo $PATH | tr ":" "\n"'  # Print path components, one per line


# -----------------------------------------------------------------------------
# Variable exports
# -----------------------------------------------------------------------------

export PATH=$PATH:$HOME/.bin
export EDITOR=$(which vim);
export PS1="\[\e[38;5;011m\]\u \[\e[38;5;255m\]\h \[\e[38;5;011m\]\W \[\e[38;5;255m\]\$ \[\e[m\]";

# Add colors for macos
if [[ "$(uname)" == "Darwin" ]]; then
  export CLICOLOR=1;
  export LSCOLORS=GxFxCxDxBxegedabagaced;
fi

export HOMEBREW_NO_ANALYTICS=1

# Configure bash history
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:ll:bg:fg:history'
export HISTTIMEFORMAT='%F %T '


# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

mkd() {
  mkdir -p "$@" && cd "$@"
}

bkp() {
  cp "$@" $(date +%Y%m%d_%s_)"$@"
}

# Set colors for man
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}


