[[ -f ~/.bashrc ]] && source ~/.bashrc

# -----------------------------------------------------------------------------
# > zsh options
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

# Move via words like bash
autoload -U select-word-style
select-word-style bash

# Key bindings
# Look at `man zshzle` and `bindkey -l` and `zle -al`
bindkey -v
bindkey -v "^A" beginning-of-line
bindkey -v "^E" end-of-line
bindkey -v "^F" forward-char
bindkey -v "^B" backward-char
bindkey -v "^P" history-search-backward
bindkey -v "^N" history-search-forward
bindkey -v "^K" kill-line
bindkey -v "^R" history-incremental-search-backward

export PROMPT="%F{$pri_bg_xt}%2~ %f%# "

function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd) printf '\033[2 q';;
    viins|main) printf '\033[4 q';;
  esac
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select


# -----------------------------------------------------------------------------
# > Initialization
# -----------------------------------------------------------------------------

# Load local settings
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# Auto-attach a tmux session
if [ -x "$(command -v tmux)" ]; then
    if [ -z "$TMUX" ]; then
        tmux attach || tmux new-session
        exit
    fi
fi
