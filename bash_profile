#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# .bash_profile file
#
# @author  Zaid Kokaja
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if [ -f ~/.bashrc ]; then         # Source bash resource file
  . ~/.bashrc                 
fi

if [ "$TERM" != "screen" ]; then  # Start screen/reattach
  exec screen -ARR                
fi
