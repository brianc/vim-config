.PHONY: update install

update:
	./update.sh

install: update
	ln -s .vimrc ~
	ln -s .vim ~
