#!/bin/zsh
# Command palette for tmux: type to fuzzy-filter the entries in
# ~/.config/tmux/palette, Enter to pick one. Meant to run in the popup opened
# by prefix p, which runs the picked command (left in @palette_cmd) once the
# popup closes, so commands that open menus or panes don't clash with it.
setopt extendedglob

palette=${XDG_CONFIG_HOME:-$HOME/.config}/tmux/palette
prefix=$(tmux show -gv prefix)
tmux set -gu @palette_cmd

# Parse "label | key | command" lines. The key is a single word or empty, so
# a command can itself contain " | ".
typeset -a labels keys cmds
while IFS= read -r line; do
    [[ $line == [[:space:]]#(\#*|) || $line != *' | '* ]] && continue
    rest=${${line#* | }##[[:space:]]#}
    if [[ $rest =~ '^([^ ]+) +\| +(.*)$' ]]; then
        key=$match[1] cmd=$match[2]
    elif [[ $rest =~ '^\| *(.*)$' ]]; then
        key= cmd=$match[1]
    else
        continue
    fi
    labels+=("${${line%% | *}%%[[:space:]]#}")
    cmds+=("$cmd")
    case $key in
        '') keys+=('') ;;
        root:*) keys+=("${key#root:}") ;;
        *) keys+=("$prefix $key") ;;
    esac
done < $palette

keywidth=0
for key in $keys; (( ${#key} > keywidth )) && keywidth=${#key}

# Score $1 against query $2 as a case-insensitive subsequence, favouring
# consecutive letters, word starts and early matches. Sets REPLY to the score
# and reply to the matched positions; fails if $2 isn't a subsequence.
score() {
    local s=${(L)1} q=${(L)2}
    local -i i=1 j last=0 total=0
    reply=()
    for (( j = 1; j <= ${#q}; j++ )); do
        while (( i <= ${#s} )) && [[ ${s[i]} != "${q[j]}" ]]; do (( i++ )); done
        (( i > ${#s} )) && return 1
        (( total += 1 ))
        (( i == last + 1 )) && (( total += 5 ))
        { (( i == 1 )) || [[ ${s[i-1]} == [[:space:][:punct:]] ]] } && (( total += 8 ))
        reply+=($i)
        last=i
        (( i++ ))
    done
    REPLY=$(( total * 100 - reply[1] ))
}

# Fill shown with the indices of matching entries, best first (ties keep file
# order), and hits with each one's matched positions.
filter() {
    shown=() hits=()
    local -a ranked
    local -i n
    for (( n = 1; n <= $#labels; n++ )); do
        if [[ -z $query ]]; then
            shown+=($n)
        elif score $labels[n] $query; then
            ranked+=("${(l:8::0:)$(( 10000000 - REPLY ))}:${(l:4::0:)n}")
            hits[$n]=" ${reply} "
        fi
    done
    [[ -n $query ]] && for n in ${${(o)ranked}#*:}; shown+=($n)
    sel=1 top=1
}

render() {
    local out=$'\e[?25l\e[H' label key line c padding
    local -i width=$(( cols - keywidth - 4 )) row n i
    (( sel > $#shown )) && sel=$#shown
    (( sel < 1 )) && sel=1
    (( sel < top )) && top=sel
    (( sel >= top + rows - 1 )) && top=$(( sel - rows + 2 ))

    # Rows start with a newline rather than end with one, so the last row
    # doesn't scroll the popup
    out+=$'\e[1m > \e[22m'"$query"$'\e[K'
    for (( row = 0; row < rows - 1; row++ )); do
        out+=$'\r\n'
        n=${shown[top + row]:-0}
        if (( n == 0 )); then
            out+=$'\e[K'
            continue
        fi
        label=${labels[n][1,width]}
        line=
        for (( i = 1; i <= ${#label}; i++ )); do
            c=${label[i]}
            if [[ ${hits[$n]} == *" $i "* ]]; then
                line+=$'\e[1;34m'"$c"$'\e[22;39m'
            else
                line+=$c
            fi
        done
        printf -v padding '%*s' $(( width - ${#label} )) ''
        line=" $line$padding "$'\e[2m'"${(l:keywidth:)keys[n]}"$'\e[22m '
        (( top + row == sel )) && line=$'\e[7m'"$line"$'\e[27m'
        out+="$line"$'\e[K'
    done
    [[ $#shown -eq 0 ]] && out+=$'\e[2;1H\e[2m  no matches\e[22m'
    out+=$'\e[J\e[1;'$(( ${#query} + 4 ))$'H\e[?25h'
    print -rn -- "$out"
}

resize() { read rows cols < <(stty size </dev/tty) }

cleanup() { stty $saved_stty </dev/tty; print -n $'\e[?25h' }
saved_stty=$(stty -g </dev/tty)
trap cleanup EXIT
trap 'exit 1' INT TERM
trap 'resize; render' WINCH
stty -echo -icanon -icrnl -isig </dev/tty

typeset -A hits
typeset -a shown
query=
resize
filter

while true; do
    render
    read -sk1 k </dev/tty || exit 1
    case $k in
        $'\e')
            # An escape sequence arrives all at once; a lone Esc is quitting
            if read -sk2 -t 0.02 seq </dev/tty; then
                case $seq in
                    '[A'|OA) (( sel-- )) ;;
                    '[B'|OB) (( sel++ )) ;;
                esac
            else
                exit 0
            fi
            ;;
        $'\r')
            (( $#shown )) || continue
            tmux set -g @palette_cmd "$cmds[shown[sel]]"
            exit 0
            ;;
        $'\x03'|$'\x07') exit 0 ;;                       # C-c C-g
        $'\x10'|$'\x0b') (( sel-- )) ;;                  # C-p C-k
        $'\x0e'|$'\n') (( sel++ )) ;;                    # C-n C-j
        $'\x7f'|$'\b') query=${query[1,-2]}; filter ;;   # Backspace C-h
        $'\x15') query=; filter ;;                       # C-u
        $'\x17') query=${${query%%[[:space:]]#}%%[^[:space:]]#}; filter ;;  # C-w
        [[:print:]]) query+=$k; filter ;;
    esac
done
