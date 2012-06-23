#!/bin/bash
cd .vim/bundle
for dir in `find . -name ".git" | sed -n "s/\.git//gp"`;do
    cd $dir
    git pull
    cd -
done
