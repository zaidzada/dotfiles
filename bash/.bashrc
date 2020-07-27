# -----------------------------------------------------------------------------
# Environment settings
# -----------------------------------------------------------------------------

export EDITOR="vim"
export PATH=$PATH:$HOME/.bin
export HOMEBREW_NO_ANALYTICS=1


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
# macOS specifics
# -----------------------------------------------------------------------------

# Add colors for macos
if [[ "$(uname)" == "Darwin" ]]; then

    # Add colors
    export CLICOLOR=1;
    export LSCOLORS=GxFxCxDxBxegedabagaced;

    man() {
      env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
    }

fi


# -----------------------------------------------------------------------------
# bash options
# -----------------------------------------------------------------------------

shopt -s cdspell
shopt -s cmdhist
shopt -s histappend
shopt -s nocaseglob
shopt -s checkwinsize

export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:ll:bg:fg:history'
export HISTTIMEFORMAT='%F %T '

export PS1="\[\e[38;5;011m\]\u \[\e[38;5;255m\]\h \[\e[38;5;011m\]\W \[\e[38;5;255m\]\$ \[\e[m\]";

# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

mkd() {
  mkdir -p "$@" && cd "$@"
}

bkp() {
  cp "$@" $(date +%Y%m%d_%s_)"$@"
}


# -----------------------------------------------------------------------------
# Initialization
# -----------------------------------------------------------------------------

# Auto-attach a tmux session
if [ -x "$(command -v tmux)" ]; then
    # Do not run when already inside of a `tmux` session
    if [ -z "$TMUX" ]; then
        # Attach to an existing session, or create a new session
        tmux attach || tmux new-session
    fi
fi

