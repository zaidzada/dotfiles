###############################################################################
# .bash_aliases
#
# @author Zaid Kokaja
###############################################################################

alias ll='ls -l'                       # Common alias
alias lla='ls -la'                     # List all hidden folders

alias mv='mv -i'                       # Prompts if overriding a file
alias cp='cp -i'                       # Prompts if overriding a file

alias vi='vim'                         # Always use vim, not vi
alias grep='grep --colour=auto'        # Enable color highlighting

alias df='df -h'                       # Human readable figures
alias du='du -h'                       # Human readable figures

alias ..='cd ..'                       # Go back one dir
alias ...='cd ../..'                   # Go back two dirs

alias lln='find . -maxdepth 1 -type l -exec ls -l {} \;'
alias mountvbox='mount -t vboxsf -o uid=$UID,gid=$(id -g)'
alias prettyjson='python -m json.tool'
alias path='echo -e ${PATH//:/\\n}'    # Print path components, one per line
