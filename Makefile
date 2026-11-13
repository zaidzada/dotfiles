# ==============================================================================
# DOTFILES BOOTSTRAPPER
# Organizes environment using XDG Base Directory Specification.
# ==============================================================================

# --- 1. PATH DEFINITIONS ---
# Use ?= to allow environment overrides
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_CACHE_HOME  ?= $(HOME)/.cache
XDG_DATA_HOME   ?= $(HOME)/.local/share
XDG_STATE_HOME  ?= $(HOME)/.local/state
XDG_BIN_HOME    ?= $(HOME)/.local/bin

DIRS := $(XDG_CONFIG_HOME) $(XDG_DATA_HOME) $(XDG_CACHE_HOME) $(XDG_STATE_HOME) $(XDG_BIN_HOME)

# --- 2. FILE DISCOVERY ---
# Dynamically find what needs to be linked
CONFIG_SOURCES := $(wildcard config/*)
CONFIG_TARGETS := $(patsubst config/%,$(XDG_CONFIG_HOME)/%,$(CONFIG_SOURCES))

BIN_SOURCES    := $(wildcard local/bin/*)
BIN_TARGETS    := $(patsubst local/bin/%,$(XDG_BIN_HOME)/%,$(BIN_SOURCES))

TMUX_PLUG := ${XDG_CONFIG_HOME}/tmux/plugins/tpm

# --- 3. CORE TARGETS ---
.PHONY: all

all: $(DIRS) ${HOME}/.zshenv $(CONFIG_TARGETS) $(BIN_TARGETS)

help:
	@echo "Usage: make [all|info]"

# --- 4. INSTALLATION RULES ---

# Ensure XDG base directories exist
$(DIRS):
	@mkdir -p $@

# Bootstraps the Zsh environment
${HOME}/.zshenv:
	@ln -sfv ${PWD}/config/zsh/zshenv ${HOME}/.zshenv

# Static pattern rule for config folders
$(CONFIG_TARGETS): $(XDG_CONFIG_HOME)/%: config/%
	@mkdir -p $(dir $@)
	@ln -sfvn $(abspath $<) $@

# Static pattern rule for local binaries
$(BIN_TARGETS): $(XDG_BIN_HOME)/%: local/bin/%
	@mkdir -p $(dir $@)
	@ln -sfvn $(abspath $<) $@

# --- 5. DIAGNOSTICS ---
info:
	@echo "--- Environment Configuration ---"
	@printf "%-20s %s\n" "DOTFILES_DIR:" "$(PWD)"
	@printf "%-20s %s\n" "XDG_CONFIG_HOME:" "$(XDG_CONFIG_HOME)"
	@printf "%-20s %s\n" "XDG_CACHE_HOME:" "$(XDG_CACHE_HOME)"
	@printf "%-20s %s\n" "XDG_BIN_HOME:" "$(XDG_BIN_HOME)"
	@printf "%-20s %s\n" "XDG_DATA_HOME:" "$(XDG_DATA_HOME)"
	@printf "%-20s %s\n" "XDG_STATE_HOME:" "$(XDG_STATE_HOME)"
	@echo ""
	@echo "--- Detected Config Folders ---"
	@echo "$(CONFIG_SOURCES)" | tr ' ' '\n' | sed 's/^/  - /'
	@echo ""
	@echo "--- Detected Binaries ---"
	@echo "$(BIN_SOURCES)" | tr ' ' '\n' | sed 's/^/  - /'