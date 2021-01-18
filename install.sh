#!/usr/bin/env bash

# Safe bash
set -euo pipefail
IFS=$'\n\t'

dryrun=
target=""

# Parse args
while getopts ":hnt:" opt; do
  case ${opt} in
    t )
      target=$OPTARG
      if ! [[ -d "$target" ]]; then
          echo "Target '$target' is not a directory"
          exit 1
      fi
      ;;
    n )
      dryrun="echo"
      ;;
    h )
      echo "Usage:"
      echo "    install -n                  Dry run. Print the commands."
      echo "    install -t target           Only install $(target) folder."
      echo "    install -h                  Display this help message."
      exit 0
      ;;
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))


if [[ -n "$dryrun" ]]; then
    echo "Just a dry run! No commands will be executed."
fi

# Backup existing files
if ! [[ -d backups ]]; then
    $dryrun mkdir backups
fi

for df in $(git ls-files "${target:-.}"); do
    if [[ -f $HOME/${df#*/} ]]; then
        $dryrun cp "$HOME/${df#*/}" backups/
    fi
done

# archive backups
$dryrun tar czf "backups-$(date +%Y%m%d_%s).tgz" backups
$dryrun rm -r backups


# Set up symlinks

# Choose which directory, or all
if [[ -z "$target" ]]; then
    dotfiles=$(find "$PWD" -maxdepth 2 -mindepth 2 -name '.*')
else
    dotfiles=$(ls -1A "$target")
fi

for fn in $dotfiles; do
    $dryrun ln -sf "$fn $HOME/$(basename $fn)"
done
