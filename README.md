# dotfiles

See `init`.

### Linux packages

Install these essentials without `sudo` privileges.

Note, `tmux` does not automatically create an AppImage with every release, yet.
```shell
curl -Lo local/bin/tmux --create-dirs \
    https://github.com/nelsonenzo/tmux-appimage/releases/download/3.2a/tmux.appimage
chmod u+x lobal/bin/tmux
```

```shell
curl -Lo local/bin/nvim --create-dirs \
    https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x local/bin/nvim
```

```shell
curl -OL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
shasum -a 256 Miniconda3*
# Verify hash here https://docs.conda.io/en/latest/miniconda.html
bash Miniconda3*
# Use /home/$USER/.local/opt/miniconda3 as installation path
```

- https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64


## Resources

- https://wiki.archlinux.org/title/XDG_Base_Directory
- https://dotfiles.github.io/inspiration/
- https://github.com/rupa/z
