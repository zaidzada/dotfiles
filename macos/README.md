# macOS

## for a new mac

- [ ] sign in to iCloud
- [ ] git clone https://github.com/zkokaja/dotfiles.git
- [ ] ./dotfiles/macOS/macos
- [ ] configure keyboard modifiers 
- [ ] mkdir -p $HOME/Library/KeyBindings/ && ln -s $PWD/macos/DefaultKeyBinding.dict $HOME/Library/KeyBindings
- [ ] install homebrew package
- [ ] brew bundle install --file dotfiles/macos/Brewfile
- [ ] download certain apps from the app store (see Brewfile)
- [ ] sudo sed -i -- '2s/^/auth sufficient pam_tid.so\n/' /etc/pam.d/sudo
- [ ] add internet accounts
- [ ] manually configure dock, ssh config
- [ ] install xcode and xcode-select --install
- [ ] github ssh keys (ssh-keygen)
- [ ] ssh-copy-id
- [ ] terminal profile
- [ ] add internet accounts
- [ ] custom colors (PMS) (save somewhere? and create matplotlib?)
- [ ] check keyboard shortcuts
