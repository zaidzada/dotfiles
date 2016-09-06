###############################################################################
# .bash_aliases
#
# @author Zaid Kokaja
###############################################################################

alias ll='ls -l'                       # Common alias
alias la='ls -a'                       # Common alias

alias mv='mv -i'                       # Prompts if overriding a file
alias cp='cp -i'                       # Prompts if overriding a file

alias vi='vim'                         # Always use vim, not vi
alias sudo='sudo '                     # Autocomplete after using sudo
alias mkdir='mkdir -p'                 # Create parent directories if needed

alias df='df -h'                       # Human readable format
alias du='du -h --max-depth=0'         # Don't recurse into subdirectories

alias path='echo -e ${PATH//:/\\n}'    # Print path components, one per line

alias ..='cd ..'                       # Go back one dir!
alias ...='cd ../..'                   # Go back two dirs!

alias prettyjson='python -m json.tool'
