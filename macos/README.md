# macOS

## for a new mac

- sign in to iCloud
- git clone https://github.com/zkokaja/dotfiles.git (switch to-xdg for now)
- ./dotfiles/macOS/macos
- configure keyboard modifiers manually for now in System Prefs
- TODO scroll direction?
- mkdir -p Library/KeyBindings/ && ln -sfv $PWD/dotfiles/macos/DefaultKeyBinding.dict Library/KeyBindings/
- /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
- but see this next time https://stackoverflow.com/a/55021458 and use XDG dirs probably
- brew bundle install --file dotfiles/macos/Brewfile (may want to comment out some casks depending on usage)
