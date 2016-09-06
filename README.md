# dotfiles

My UNIX dot files.

## Structure

Based on [GNU Stow](https://www.gnu.org/software/stow/):

   .
   ├── bash
   │   ├── .bash_aliases
   │   └── .bashrc
   ├── .gitignore
   ├── README.md
   ├── tmux
   │   └── .tmux.conf
   └── vim
       └── .vimrc

## Usage

```shell
$ git clone https://github.com/zkokaja/dotfiles.git
$ cd dotfiles
$ stow bash
$ stow tmux
$ stow vim
```

Use `-t ~` if parent directory is not home.
