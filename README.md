# dotfiles

See `init`.

### Linux packages

Install these essentials without `sudo` privileges.

Note, `tmux` does not automatically create an AppImage with every release, yet.
```shell
curl -Lo ~/.bin/tmux --create-dirs \
    https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage
chmod u+x ~/.bin/tmux
```
But see this https://github.com/nelsonenzo/tmux-appimage

```shell
curl -Lo ~/.bin/nvim --create-dirs \
    https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x ~/.bin/nvim
```

- https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
- https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64


## Resources

- https://github.com/jimeh/tmux-themepack
- https://wiki.archlinux.org/title/XDG_Base_Directory
- https://dotfiles.github.io/inspiration/
- https://github.com/rupa/z
