# macOS

## for a new mac

- [ ] sign in to iCloud
- [ ] `git clone https://github.com/zkokaja/dotfiles.git`
- [ ] `./dotfiles/macos/macos`
- [ ] configure keyboard modifiers 
- [ ] `mkdir -p $HOME/Library/KeyBindings/ && ln -s $PWD/macos/DefaultKeyBinding.dict $HOME/Library/KeyBindings`
- [ ] install [brew](https://brew.sh)
- [ ] `brew bundle install --file dotfiles/macos/Brewfile`
- [ ] download certain apps from the app store (see Brewfile)
- [ ] `sudo sed -i -- '2s/^/auth sufficient pam_tid.so\n/' /etc/pam.d/sudo`
- [ ] add internet accounts
- [ ] add ssh config
- [ ] install xcode and `xcode-select --install`
- [ ] github ssh keys (`ssh-keygen`)
- [ ] `ssh-copy-id`
- [ ] terminal profile
- [ ] check keyboard shortcuts
