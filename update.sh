#! /bin/bash

cd ~/.vim/bundle
for i in `ls`; do
  cd "$i"
  git checkout master
  git pull
  cd ..
done
