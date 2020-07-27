# -----------------------------------------------------------------------------
# Environment settings
# -----------------------------------------------------------------------------

export EDITOR="vim"
export PATH="${HOME}/bin:${PATH}"
export HOMEBREW_NO_ANALYTICS=1


# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -F'
alias ll='ls -lh'
alias llt='ls -ltr'
alias lg='ls -1 | grep'
alias mv='mv -i'
alias cp='cp -i'
alias vi='vim'
alias pgrep='pgrep -fl'


# -----------------------------------------------------------------------------
# macOS specifics
# -----------------------------------------------------------------------------

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
# zsh options
# -----------------------------------------------------------------------------

bindkey -e
setopt autocd
setopt correct

# History
setopt append_history
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Completion
zmodload -i zsh/complist
autoload -Uz compinit
compinit

# Move like bash
autoload -U select-word-style
select-word-style bash


# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

# Colors: https://gist.github.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263
export PROMPT="%F{214}%n %F{255}%m %F{214}%2~ %F{255}%# %f"


# -----------------------------------------------------------------------------
# Initialization
# -----------------------------------------------------------------------------

# Load local settings
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# Auto-attach a tmux session
if [ -x "$(command -v tmux)" ]; then
    if [ -z "$TMUX" ]; then
        tmux attach || tmux new-session
    fi
fi

