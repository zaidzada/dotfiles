all: bash vim tmux

bash:
	mv ~/.bashrc ~/.bashrc.old
	cp -i bashrc ~/.bashrc
	mv ~/.bash_aliases ~/.bash_aliases.old
	cp -i bash_aliases ~/.bash_aliases 

vim:
	mv ~/.vimrc ~/.vimrc.old
	cp -i vimrc ~/.vimrc

tmux:
	mv ~/.tmux.conf ~/.tmux.conf.cold
	cp -i tmux.conf ~/.tmux.conf
