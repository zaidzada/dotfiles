# Dotfiles
A minimalist, Make-based configuration system designed for XDG compliance and portability across environments.

## 🚀 Quick Start
To bootstrap a new machine, clone this repository and run:

```Bash
cd ~/dotfiles
make
```
**Hint:** use `make -n` for a "dry-run" test.


## 🛠 Features
- **XDG Compliant**: Moves configuration out of `$HOME` and into `.config`, `.local`, etc.
- **Idempotent:** Safe to run multiple times; it only updates what is necessary.
- **Declarative:** Uses GNU Make pattern rules to manage symlinks for `config/*` and `local/bin/*`.
- **Self-Documenting:** Use `make info` to see the current variable mappings.


## 📂 Structure
| Directory     | Description                    | Destination     |
|---------------|--------------------------------|-----------------|
| `config/`     | Tool-specific configurations   | `~/.config/`    |
| `local/bin/`  | Personal scripts and binaries  | `~/.local/bin/` |
| `config/zsh/` | Zsh environment (bootstrapper) | `~/.zshenv`     |


## 📋 Available Commands
- `make`: The default target. Validates directories, links files, and installs Vim/Tmux plugins.
- `make info`: Prints all paths and detected files for verification.
- `make vim`: Specifically handles `vim-plug` installation.
- `make tmux`: Specifically handles `tpm` (Tmux Plugin Manager) installation.