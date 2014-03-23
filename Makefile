install: vim git

vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim/vimfiles ~/.vim
	ln -s `pwd`/vim/_vimrc ~/.vimrc

git:
	rm -f ~/.gitconfig ~/.gitignore
	ln -s `pwd`/.gitconfig ~/.gitconfig
	ln -s `pwd`/.gitignore ~/.gitignore
