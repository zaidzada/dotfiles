[[ $- != *i* ]] && return

# -----------------------------------------------------------------------------
# > Environment settings
# -----------------------------------------------------------------------------

export EDITOR="vim"
export PATH=$HOME/.bin:$PATH
export HOMEBREW_NO_ANALYTICS=1

# Set colors for less. See `man termcap`.
export LESS_TERMCAP_md=$(tput bold; tput setaf $pri_bg_xt)  # bold
export LESS_TERMCAP_mb=$(tput bold; tput setaf $prim_bg_xt)  # blink
export LESS_TERMCAP_so=$(tput setaf $pri_fg_xt; tput setab $pri_bg_xt)
export LESS_TERMCAP_us=$(tput smul)  # underline
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)

export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


# -----------------------------------------------------------------------------
# > Aliases
# -----------------------------------------------------------------------------

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Listing
alias ls='ls -F'
alias ll='ls -lh'
alias lt='ls -lhtr'
alias la='ls -lhtA'
alias ld='ls -lhtd'

# Confirmation
alias mv='mv -i'
alias cp='cp -i'

# Misc
alias vi='vim'
alias df='df -h'
alias du='du -h'
alias path='echo $PATH | tr ":" "\n"'
alias td='tmux detach'

# Colors
alias pgrep='pgrep --color=auto -fl'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# -----------------------------------------------------------------------------
# > Platform specifics
# -----------------------------------------------------------------------------

# Add colors for macos
if [[ "$(uname)" == "Darwin" ]]; then

    alias dircolors='gdircolors'

    if [ -x "$(command -v gls)" ]; then
        alias ls='gls --color=auto -F -X --group-directories-first'
    else
        alais ls='ls -F -G'
        export LSCOLORS=GxFxCxDxBxegedabagaced;
    fi

elif [[ "$(uname)" == "Linux" ]]; then

    alias ls='ls --color=auto -F -X --group-directories-first'

fi


# ls colors
if [[ -f ~/.dircolors ]]; then
    eval "$(dircolors ~/.dircolors)"
else
    eval "$(dircolors)"
fi

# -----------------------------------------------------------------------------
# > Functions
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
# > bash options
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


col="$(tput setaf $pri_bg_xt)"
res="$(tput sgr0)"
export PS1="\[$col\]\W \[$res\]\$ ";


# -----------------------------------------------------------------------------
# > Initialization
# -----------------------------------------------------------------------------

# Load local settings
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi

# Auto-attach a tmux session
if [ -x "$(command -v tmux)" ]; then
    if [ -z "$TMUX" ]; then
        tmux attach || tmux new-session
        exit
    fi
fi
