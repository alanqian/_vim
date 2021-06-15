#! /bin/sh
#
# build-ycm.sh - build ycm on macOS
# Copyright (C) 2021 alan <qian.guoxiang@qq.com>
#
# Distributed under terms of the MIT license.
#
# Reference:
# [YouCompleteMe Install](https://ycm-core.github.io/YouCompleteMe/#installation)

# step 0. preparation for cmake, llvm/clang, go, python/jedi, node/typescript, etc
brew install cmake llvm || { echo 'brew install llvm failed' ; exit 1; }
brew upgrade go python node
pip3 install jedi
npm install -g typescript

# step 1. clone git repository
mkdir -p tmp ; cd tmp
git clone --recursive https://github.com/ycm-core/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive || { echo 'git submodule update failed' ; exit 1; }
cd ../..

# step 2. Compile YCM
# Compiling YCM all in one
cd tmp/YouCompleteMe
$ python3 ./install.py --all
cd -
exit 0

# Compiling YCM without semantic support for C-family languages:
$ python3 ./install.py

# or Compiling YCM with semantic support for C-family languages through clangd:
$ python3 ./install.py --clangd-completer

# other compile options:
# --ts-completer    - for javascript/typescript support
# --go-completer    - for go support
# --rust-completer  - for rust support
