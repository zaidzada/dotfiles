[[ -f ~/.bashrc ]] && source ~/.bashrc

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

# Move via words like bash
autoload -U select-word-style
select-word-style bash

# Key bindings
bindkey "^F" forward-word
bindkey "^B" backward-word
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward


# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

theme_primary=${ZTHEME_PRM_COL:-7}
export PROMPT="\
%F{$theme_primary}%n \
%F{255}%m %F{$theme_primary}%2~ \
%F{255}%# %f"

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
        exit
    fi
fi
