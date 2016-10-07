#!/bin/bash

# Installs files in bin/ to ~/bin by making symlinks to them

force=false
if [[ $1 == "--force" ]]; then
  force=true
fi

mkdir -p ~/bin

for F in bin/*; do
  linkname=$(basename $F)
  fullpath="$(pwd)/$linkname"

  pushd ~/bin >/dev/null

  if [ -e $linkname ]; then
    if [[ force == "true" ]]; then
      echo "$linkname already exists, removing $linkname"
      rm $linkname
    else
      echo "$linkname already exists, skipping $linkname"
      continue
    fi
  fi

  echo ln -s $linkname $fullpath
  ln -s $linkname $fullpath

  popd > /dev/null
done
