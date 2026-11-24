#!/bin/zsh
# Picker for the app launcher: lists the layouts in ~/.config/tmux/layouts.
# Up/down (or C-p/C-n, k/j) to move, then Enter or w to open the layout as a
# window, s as a session, f as a float. Meant to run in the popup opened by
# prefix d, which runs the launch (left in @launch_cmd) once the popup
# closes, so a float doesn't clash with the popup.

dir=${XDG_CONFIG_HOME:-$HOME/.config}/tmux/layouts
launch=${0:A:h}/launch
tmux set -gu @launch_cmd

typeset -a names descs
for f in $dir/*(N.); do
    names+=(${f:t})
    descs+=("$(sed -n '1s/^# *//p' $f)")
done

namewidth=0
for n in $names; (( ${#n} > namewidth )) && namewidth=${#n}

hint=$'\e[2m⏎/w window  s session  f float  esc quit\e[22m'

render() {
    local out=$'\e[?25l\e[H' line
    local -i list=$(( rows - 2 )) row i width=$(( cols - namewidth - 4 ))
    (( sel < top )) && top=sel
    (( sel >= top + list )) && top=$(( sel - list + 1 ))
    for (( row = 0; row < list; row++ )); do
        (( row )) && out+=$'\r\n'
        i=$(( top + row ))
        if (( i > $#names )); then
            out+=$'\e[K'
            continue
        fi
        line=" ${(r:namewidth:)names[i]}  ${descs[i][1,width]}"
        if (( i == sel )); then
            out+=$'\e[7m'"${(r:cols:)line}"$'\e[27m'
        else
            out+="${line[1,namewidth+3]}"$'\e[2m'"${line[namewidth+4,-1]}"$'\e[22m\e[K'
        fi
    done
    (( $#names )) || out+=$'\e[H  \e[2mno layouts in '"${(D)dir}"$'\e[22m'
    out+=$'\r\n\e[K\r\n '"$hint"$'\e[K'
    print -rn -- "$out"
}

pick() {
    (( $#names )) || return
    tmux set -g @launch_cmd \
        "run-shell \"'$launch' -c '#{client_name}' -t '#{pane_id}' -$1 '$names[sel]'\""
    exit 0
}

resize() { read rows cols < <(stty size </dev/tty) }

cleanup() { stty $saved_stty </dev/tty; print -n $'\e[?25h' }
saved_stty=$(stty -g </dev/tty)
trap cleanup EXIT
trap 'exit 1' INT TERM
trap 'resize; render' WINCH
stty -echo -icanon -icrnl -isig </dev/tty

integer sel=1 top=1
resize

while true; do
    render
    read -sk1 k </dev/tty || exit 1
    case $k in
        $'\e')
            # An escape sequence arrives all at once; a lone Esc is quitting
            if read -sk2 -t 0.02 seq </dev/tty; then
                case $seq in
                    '[A'|OA) (( sel > 1 )) && (( sel-- )) ;;
                    '[B'|OB) (( sel < $#names )) && (( sel++ )) ;;
                esac
            else
                exit 0
            fi
            ;;
        $'\r'|w) pick w ;;
        s) pick s ;;
        f) pick f ;;
        q|$'\x03'|$'\x07') exit 0 ;;                                   # q C-c C-g
        k|$'\x10') (( sel > 1 )) && (( sel-- )) ;;                     # k C-p
        j|$'\x0e'|$'\n') (( sel < $#names )) && (( sel++ )) ;;         # j C-n C-j
    esac
done
