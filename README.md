# dotfiles

My .files

## Installation

```shell
git clone https://github.com/zkokaja/dotfiles.git
cd dotfiles
bash install.sh
```

## Vim

```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Tmux

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## AppImage installations

```shell
curl -Lo ~/.bin/nvim --create-dirs \
    https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x ~/.bin/nvim
```

Note, `tmux` does not automatically create an AppImage with every release, yet.
```shell
curl -Lo ~/.bin/tmux --create-dirs \
    https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage
chmod u+x ~/.bin/tmux
```

Other:
- https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
- https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64

## Resources

- https://dotfiles.github.io/inspiration/
- https://github.com/rupa/z
