.PHONY: update install

update:
	git pull --recurse-submodules

install: update
	ln -s .vimrc ~
	ln -s .vim ~
