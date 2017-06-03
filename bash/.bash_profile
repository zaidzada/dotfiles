# .bash_profile
#
# Bash profile to source .profile and .bashrc

[[ -r "$HOME/.profile" ]] && [[ -f "$HOME/.profile" ]] && source $HOME/.profile
[[ -r "$HOME/.bashrc" ]]  && [[ -f "$HOME/.bashrc" ]]  && source $HOME/.bashrc
[[ -r /usr/local/etc/bash_completion ]]  && [[ -f /usr/local/etc/bash_completion ]]  && source /usr/local/etc/bash_completion
