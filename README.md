# _vim - Packages and Configurations for Vim

## install vim/gvim on macOS and system upgrade

    $ brew install macvim
    $ brew unlink macvim  # remember to unlink vim to macvim
    $ brew install vim
  
On macOS, vim link to system framework python, so, upgrade vim/python when system upgrade!

Upgrade python for system when using pyenv.

    $ brew install python

## vimrc

:help vimrc 
    Places for your personal initializations:
    Unix		    $HOME/.vimrc or $HOME/.vim/vimrc
    MS-Windows	$HOME/_vimrc, $HOME/vimfiles/vimrc or $VIM/_vimrc

Therefore, my vim configurations file is $HOME/.vim/vimrc.

## plugin management

Vim 8, with native package management, I put all my plugins in ~/.vim/pack/plugins/{start,opt}

~/.vim/pack/plugins/start  - autoload packages
~/.vim/pack/plugins/opt    - :packadd package-name

[Vim: So long Pathogen, hello native package loading](https://shapeshed.com/vim-packages/)

Since Git submodule is too complicated, we put .vim/pack to .gitignore

~/.vim/install/...

## python3 and package management

Many plugins are written in python, and, vim using python installed as system, which is /usr/local/bin/python3

    # using python3: make a symbol link for convenience
    $ ln -s /usr/local/bin/python3 /usr/local/bin/python

    $ otool -l `which vim`  # macOS
    $ ldd -r `which vim`  # linux

    ...
    /usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/Python (offset 24)
    ...

Remember to install python packages used by vim plugins(eg. YCM) to system version:

    $ pyenv global system
    $ pip3 install -r ${plugin-path}/requirements.txt
  
## git config

git config --global core.editor $(which vim)

## Git

To create repository: 

```
macOS: /Users/dotfiles/_vim
Linux: /Home/dotfiles/_vim

$ git init
$ git add ...
$ git commit -m "..."
$ git remote add origin git@github.com:alanqian/_vim.git
$ git push -u origin master
```

To clone repository:

```
cd
cd ~/../dotfiles/
git clone git@github.com:alanqian/_vim.git

cd
ln -s ~/../dotfiles/_vim .vim
```

## Generate helptags for plugins

```
vim
:helptags ALL
```

## Install a plugin, eg. nerdtree

    $ cd ~/.vim
    $ git clone git://github.com/scrooloose/nerdtree.git pack/plugins/start/nerdtree


## Remove a plugin, eg. nerdtree

    $ cd ~/.vim
    $ rm -rf pack/plugins/start/nerdtree


## Update plugins, eg. foo

Update a plugin, eg. foo

    $ git -C ~/.vim/pack/plugins/start/foo pull origin master

Update all plugin:

    $ for plugin in $(ls ./pack/plugins/start/); do git -C ./pack/plugins/start/${plugin} pull origin master ; done

