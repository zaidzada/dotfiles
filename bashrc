###############################################################################
# .bashrc
#
# @author Zaid Kokaja
###############################################################################

# Exit if shell is not running interactively
if [[ ! -t 0 && ! -p /dev/stdin ]]; then exit 0; fi

#------------------------------------------------------------------------------
#                         Environment configuration
#------------------------------------------------------------------------------

                                       # Set colorized prompt
PS1='\[\e[0;32m\]\u@\h\[\e[0;37m\] \w \$\[\e[00m\] '

EDITOR=$(which vim)                    # Our editor is vim
VISUAL=$(which vim)                    # Our visual is vim

                                       # Export the variables
export PS1 EDITOR VISUAL

case $(uname) in
    "Cygwin")
    alias ls='ls --color=auto'         # Use colors for ls
    alias grep='grep --colour=auto'    # Use colors for grep
    ;;

    "Linux")
    alias ls='ls --color=auto'         # Use colors for ls
    alias grep='grep --colour=auto'    # Use colors for grep
    ;;

    "Darwin")                         
    alias ls='ls -G'                   # Use colors for ls
    alias grep='grep --colour=auto'    # Use colors for grep
    export CLICOLOR=""
    export LSCOLORS=gxfxcxdxbxegEdabagacad
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
    ;;
esac

#------------------------------------------------------------------------------
#                         Alias configurations
#------------------------------------------------------------------------------

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
