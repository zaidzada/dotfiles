if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME."/.config" | endif

set runtimepath^=$XDG_CONFIG_HOME/vim/.vim
set runtimepath+=$XDG_CONFIG_HOME/vim/.vim/after
let &packpath=&runtimepath
source $XDG_CONFIG_HOME/vim/vimrc
