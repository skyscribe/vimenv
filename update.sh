#!/bin/bash
bundleDir=`pwd`/.vim/bundle
for dir in `find $bundleDir -name ".git" | sed -n "s/\.git//gp"`;do
    echo "checking on .... === $dir"
    pushd $dir > /dev/null
    if git status | grep -v "branch master";then
        git checkout master
    fi
    git pull
    popd > /dev/null
done
