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
bindkey -M viins "^D" delete-char
bindkey -M viins "^H" backward-delete-char
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M viins "^F" forward-char
bindkey -M viins "^B" backward-char
bindkey -M viins "^P" history-search-backward
bindkey -M viins "^N" history-search-forward
bindkey -M viins "^K" kill-line
bindkey -M viins "^U" backward-kill-line
bindkey -M viins "^R" history-incremental-search-backward

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
