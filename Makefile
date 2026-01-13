XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_CACHE_HOME  ?= $(HOME)/.cache
XDG_DATA_HOME   ?= $(HOME)/.local/share
XDG_STATE_HOME  ?= $(HOME)/.local/state
XDG_BIN_HOME    ?= $(HOME)/.local/bin

DIRS := $(XDG_CONFIG_HOME) $(XDG_DATA_HOME) $(XDG_CACHE_HOME) $(XDG_STATE_HOME) $(XDG_BIN_HOME)

.PHONY: all xdg vim tmux links

all: doctor xdg ${HOME}/.zshenv link_configs link_bins

REQUIRED_BINS := git curl
OPTIONAL_BINS := zsh vim
doctor:
	@echo "Checking system dependencies..."
	@for bin in $(REQUIRED_BINS); do \
		command -v $$bin >/dev/null 2>&1 || { echo "ERROR: $$bin is not installed."; exit 1; }; \
	done
	@for bin in $(OPTIONAL_BINS); do \
		command -v $$bin >/dev/null 2>&1 || { echo "WARNING: $$bin is not installed (optional)."; }; \
	done
	@echo "System check passed!"

# Create XDG directories
$(DIRS):
	mkdir -p $@

xdg: $(DIRS)
	@echo "XDG_CONFIG_HOME= " "${XDG_CONFIG_HOME}"
	@echo "XDG_DATA_HOME  = " "${XDG_DATA_HOME}"
	@echo "XDG_STATE_HOME = " "${XDG_STATE_HOME}"
	@echo "XDG_CACHE_HOME = " "${XDG_CACHE_HOME}"
	@echo "XDG_BIN_HOME   = " "${XDG_BIN_HOME}"

# Link zshenv
${HOME}/.zshenv:
	ln -sfv ${PWD}/config/zsh/zshenv ${HOME}/.zshenv

# Get a list of every directory inside config folder
ALL_CONFIGS := $(notdir $(wildcard $(PWD)/config/*))
link_configs: | $(DIRS)
	@for dir in $(ALL_CONFIGS); do \
		ln -sfvn $(PWD)/config/$$dir $(XDG_CONFIG_HOME)/$$dir; \
	done

# Get a list of every directory inside config folder
ALL_BINS := $(notdir $(wildcard $(PWD)/local/bin/*))
link_bins: | $(DIRS)
	@for bin in $(ALL_BINS); do \
		ln -sfvn $(PWD)/local/bin/$$bin $(XDG_BIN_HOME)/$$bin; \
	done

# Vim plugins
VIM_PLUG := $(XDG_CONFIG_HOME)/vim/autoload/plug.vim
$(VIM_PLUG):
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim: $(VIM_PLUG)

tmux:
	git clone https://github.com/tmux-plugins/tpm "${XDG_CONFIG_HOME}"/tmux/plugins/tpm
	"${XDG_CONFIG_HOME}"/tmux/plugins/tpm/bin/install_plugins
