#!/usr/bin/env bash

# Safe bash
set -euo pipefail
IFS=$'\n\t'

dryrun=

# TODO - add options
# TODO - if this is not the git repo, download, cd, and continue

# Backup existing files
if ! [[ -d backups ]]; then
    $dryrun mkdir backups
fi

for df in `git ls-files`; do
    if [[ -f $HOME/${df#*/} ]]; then
        $dryrun cp $HOME/${df#*/} backups/
    fi
done

# archive backups
$dryrun tar czf backups.tgz backups
$dryrun rm -r backups

# Set up symlinks

# Choose which directory, or all
if [[ $# -eq 1 ]]; then
    dotfiles=`ls -1A "$1"`
else
    dotfiles=$(find "$PWD" -maxdepth 2 -mindepth 2 -name '.*')
fi

for fn in $dotfiles; do
    $dryrun ln -sf $fn $HOME/$(basename $fn)
done
