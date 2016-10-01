# .bash_profile
#
# Bash profile to source .profile and .bashrc

[[ -r "$HOME/.profile" ]] && [[ -f "$HOME/.profile" ]] && source $HOME/.profile
[[ -f "$HOME/.bashrc" ]]  && [[ -f "$HOME/.bashrc" ]]  && source $HOME/.bashrc
