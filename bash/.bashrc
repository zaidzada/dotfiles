# .bashrc
#
# Main Bash configuration file for interactive shells

[[ "$-" != *i* ]] && return  

umask 027

shopt -s cdspell
shopt -s histappend
shopt -s nocaseglob
shopt -s checkwinsize

for file in ~/.bash_{prompt,aliases,functions,path,exports}; do
	[[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file
