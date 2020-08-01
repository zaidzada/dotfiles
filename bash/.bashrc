[[ $- != *i* ]] && return

# -----------------------------------------------------------------------------
# Environment settings
# -----------------------------------------------------------------------------

export EDITOR="vim"
export PATH=$HOME/.bin:$PATH
export HOMEBREW_NO_ANALYTICS=1

# Use the theme color if available
theme_primary=${ZTHEME_PRM_COL:-7}

# Set colors for less. See `man termcap`.
export LESS_TERMCAP_mb=$(tput bold; tput setaf $theme_primary)
export LESS_TERMCAP_md=$(tput bold; tput setaf $theme_primary)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab $theme_primary)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)

export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Listing
alias ls='ls -F'
alias ll='ls -lh'
alias llt='ls -lhtr'
alias lla='ll -lhtA'
alias lln='ll -lhtA | grep ^l'

# Confirmation
alias mv='mv -i'
alias cp='cp -i'

# Misc
alias vi='vim'
alias df='df -h'
alias du='du -h'
alias path='echo $PATH | tr ":" "\n"'

# Colors
alias pgrep='pgrep --color=auto -fl'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# -----------------------------------------------------------------------------
# platform specifics
# -----------------------------------------------------------------------------

# Add colors for macos
if [[ "$(uname)" == "Darwin" ]]; then

    export CLICOLOR=1;
    export LSCOLORS=GxFxCxDxBxegedabagaced;

elif [[ "$(uname)" == "Linux" ]]; then

    alias ls='ls --color=auto -F -X --group-directories-first'

fi


# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

mkd() {
  mkdir -p "$@" && cd "$@"
}

bkp() {
  cp "$@" $(date +%Y%m%d_%s_)"$@"
}


# NOTE - Only continue if on bash
if [[ -z "$BASH_VERSION" ]]; then
    return
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

export PS1="\
$(tput setaf $theme_primary)\u $(tput sgr0)\h \
$(tput setaf $theme_primary)\W $(tput sgr0)\$ $(tput sgr0)";


# -----------------------------------------------------------------------------
# Initialization
# -----------------------------------------------------------------------------

# Load local settings
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi

# Auto-attach a tmux session
if [ -x "$(command -v tmux)" ]; then
    if [ -z "$TMUX" ]; then
        tmux attach || tmux new-session
    fi
fi
