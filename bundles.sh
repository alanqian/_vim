#!/bin/bash

echo "Install vim bundles from bundles.md"

if [ ! -f urls ] ; then
  grep "^https://github.com" bundles.md > urls
fi

declare -a gits
declare -a plugins
IFS=$'\n'
# gits=($(sed -e 's:^https:git:' -e 's:$:.git:' urls))
gits=($(sed -e 's|^https://github.com/|git@github.com:|' -e 's:$:.git:' urls))
plugins=($(sed -e 's:.*/::' urls))

count=${#gits[*]}
target='pack/plugins/start'
mkdir -p $target
echo "# install vim plugins to ${target}" > install.sh
echo >> install.sh
for (( i=0; i<=$(( $count - 1 )); i++ ))
do
  git=${gits[$i]}
  plugin=${plugins[$i]}
  echo "adding $plugin..."
  # git submodule add $git $target/$plugin
  # git submodule init && git submodule update
  # git commit -m "add $plugin plugin"
  # git clone $git $target/$plugin
  echo
  echo "# add $plugin" >> install.sh
  echo "git clone $git $target/$plugin" >> install.sh
  echo >> install.sh
done

# rm temp file url
rm urls
echo "install.sh generated, first run it"
echo "then run helptags ALL in vim"
echo "done"
