###############################################################################
# .bashrc
#
# @author Zaid Kokaja
###############################################################################

#------------------------------------------------------------------------------
#                         Environment configuration
#------------------------------------------------------------------------------

CLASSPATH=/usr/local/java/:.           # Set the class path for Java

                                       # Set colorized prompt
PS1='\[\e[0;32m\]\u@\h\[\e[0;34m\] \w \$\[\e[00m\] '

EDITOR=$(which vim)                    # Our editor is vim
VISUAL=$(which vim)                    # Our visual is vim

                                       # Export the variables
export PATH CLASSPATH PS1 HISTFILE VI EDITOR VISUAL

case $(uname) in
    "Linux")
    alias ls='ls --color=auto'         # Use colors for ls
    alias grep='grep --colour=auto'    # Use colors for grep
    ;;

    "OpenBSD")
    if [ "$TERM" == "xterm" ]; then
        export TERM="xterm-xfree86"
    fi
    if [ -x "$(which colorls)" ]; then
        alias ls='colorls -G'
        export CLICOLOR=""
        export LSCOLORS=gxfxcxdxbxegEdabagacad
    fi
    ;;

    "Darwin")                         
    alias ls='ls -G'                   # Use colors for ls
    alias grep='grep --colour=auto'    # Use colors for grep
    export CLICOLOR=""
    export LSCOLORS=gxfxcxdxbxegEdabagacad
    ;;
esac

#------------------------------------------------------------------------------
#                         Safety!
#------------------------------------------------------------------------------

ulimit -S -c 0                         # Set core file size limit
ulimit -S -u 256                       # Set max user processes limit
ulimit -S -s 8192                      # Set stack size limit

#------------------------------------------------------------------------------
#                         Alias configurations
#------------------------------------------------------------------------------

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
