###############################################################################
# .bashrc
#
# @author Zaid Kokaja
###############################################################################

# Exit if shell is not running interactively
[[ "$-" != *i* ]] && return  

#------------------------------------------------------------------------------
#                         Environment variables
#------------------------------------------------------------------------------
                                       # Set colorized prompt
PS1='\[\e[0;32m\]\u@\h\[\e[0;37m\] \w \$\[\e[00m\] '

EDITOR=$(which vim)                    # Our editor is vim
VISUAL=$(which vim)                    # Our visual is vim

                                       # Export the variables
export PS1 EDITOR VISUAL

#------------------------------------------------------------------------------
#                         Bash configureation
#------------------------------------------------------------------------------

shopt -s cdspell                       # Fix small typos
umask 027                              # Change default file permissions

#------------------------------------------------------------------------------
#                         Alias configurations
#------------------------------------------------------------------------------

if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi
