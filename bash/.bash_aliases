# .bash_aliases
#
# Bash alias configuration

alias ls='ls -F'                       # Display trailing file indicator
alias ll='ls -l'                       # List in long format

alias mv='mv -i'                       # Prompts if overriding a file
alias cp='cp -i'                       # Prompts if overriding a file

alias vi='vim'                         # Always use vim, not vi
alias grep='grep --colour=auto'        # Enable color highlighting

alias df='df -h'                       # Human readable figures
alias du='du -h'                       # Human readable figures

alias ..='cd ..'                       # Go back one dir
alias ...='cd ../..'                   # Go back two dirs

alias vie='vim -c "setl bin noswapfile viminfo="'

alias workon='source bin/activate'
alias lln='find . -maxdepth 1 -type l -exec ls -l {} \;'
alias mountvbox='mount -t vboxsf -o uid=$UID,gid=$(id -g)'
alias prettyjson='python -m json.tool'
alias path='echo $PATH | tr ":" "\n"'  # Print path components, one per line

# Only for brewed python
if [[ "$(uname)" == "Darwin" ]]; then
  alias p2='/usr/local/bin/python2'
  alias p3='/usr/local/bin/python3'
  alias pip2='/usr/local/bin/pip2'
  alias pip3='/usr/local/bin/pip3'
fi
