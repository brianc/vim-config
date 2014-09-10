.PHONY: update install

update:
	git pull --recurse-submodules
	git submodule update --recursive

install: update
	ln -s .vimrc ~
	ln -s .vim ~
