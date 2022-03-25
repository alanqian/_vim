# My Vim Plugins

## Install with Vim 8+

Use git to manage vim plugins.

Plugins located in ~/.vim/pack/plugins/{start,opt}

run bundles.sh to make install.sh, then run install.sh to install all plugins listed in this document.

```
$ bash bundles.sh
```

## Plugins

### Overview

```
Plugins for Language
  syntax highlighting
  static code analysis
  code completion
  source formatter
  code refactoring
  prgs
    equalprg
    formatprg
    makeprg
  make tools
  unit-test/run-script tools
  debuging*
  documentation tools

Lang/lang-special tools
  C/C++
  Javascript
  Ruby
  Python
```

### IDE/fast navigation

[nerdtree](
https://github.com/scrooloose/nerdtree
) - A tree explorer plugin for vim.

[tagbar](
https://github.com/majutsushi/tagbar
) - Vim plugin that displays tags in a window, ordered by scope

[ctrlp.vim](
https://github.com/kien/ctrlp.vim
) - Fuzzy file, buffer, mru, tag, etc finder.

[IndexedSearch](
https://github.com/vim-scripts/IndexedSearch
) - shows 'Nth match out of M' at every search

### IDE/test-runner

[vim-test](
https://github.com/janko/vim-test
) - Run your tests at the speed of thought

### IDE/color schemes

[vim-colorscheme-switcher](
 https://github.com/xolox/vim-colorscheme-switcher
) - Makes it easy to quickly switch between color schemes in Vim

[vim-vividchalk](
https://github.com/tpope/vim-vividchalk
) - vividchalk.vim: a colorscheme strangely reminiscent of Vibrant Ink for a certain OS X editor

[vim-monokai](
https://github.com/rickharris/vim-monokai
) - Monokai for vim (with iTerm2 theme)

### IDE/source control, async run to Quickfix Window

[vim-fugitive](
https://github.com/tpope/vim-fugitive
) - fugitive.vim: A Git wrapper so awesome, it should be illegal

[asyncrun.vim](
https://github.com/skywind3000/asyncrun.vim
) - Run Async Shell Commands in Vim 8.0 / NeoVim and Output to Quickfix Window

### IDE/code completion and fast editing

[YouCompleteMe](
https://github.com/ycm-core/YouCompleteMe
) - A code-completion engine for Vim

[emmet-vim](
https://github.com/mattn/emmet-vim
) - emmet for vim: http://emmet.io/

[vim-surround](
https://github.com/tpope/vim-surround
) - surround.vim: quoting/parenthesizing made simple

[vim-endwise](
https://github.com/tpope/vim-endwise
) - endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc

[vim-template](
https://github.com/alanqian/vim-template
) - Simple templates plugin for Vim

[UltiSnips](
https://github.com/SirVer/ultisnips
) - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!

[vim-snippets](
https://github.com/honza/vim-snippets
) - vim-snipmate / UltiSnips default snippets.

[nerdcommenter](
https://github.com/scrooloose/nerdcommenter
) - Vim plugin for intensely orgasmic commenting

[DoxygenToolkit.vim](
https://github.com/mrtazz/DoxygenToolkit.vim
) - Doxygen plugin for vim

[vim-pydocstring](
https://github.com/heavenshell/vim-pydocstring
) - Generate Python docstring to your Python script file.

[vim-jsdoc](
https://github.com/heavenshell/vim-jsdoc
) - Generate JSDoc to your JavaScript code.

* YouCompleteMe and Installation

YCM sticks to python version

YCM covers features of the following:
  jedi-vim: https://github.com/davidhalter/jedi-vim
  clang_complete: https://github.com/xavierd/clang_complete
  AutoComplPop
  Supertab
  neocomplcache
  ctags
  cscope

YCM alternatives:
    https://github.com/shougo/deoplete.nvim
    https://github.com/deoplete-plugins/deoplete-jedi
      https://github.com/davidhalter/jedi
    https://github.com/Shadowsith/vim-ruby-autocomplete
    https://github.com/ajh17/VimCompletesMe
    https://github.com/ternjs/tern_for_vim
      https://github.com/ternjs/tern

YCM also provides semantic IDE-like features in a number of languages, including:

finding declarations, definitions, usages, etc. of identifiers,
displaying type information for classes, variables, functions etc.,
displaying documentation for methods, members, etc. in the preview window,
fixing common coding errors, like missing semi-colons, typos, etc.,
semantic renaming of variables across files,
formatting code,
removing unused imports, sorting imports, etc.

[YouCompleteMe Install](https://ycm-core.github.io/YouCompleteMe/#installation)

```
# 0. preparation for llvm/clang, python/jedi, node/typescript, etc

    $ brew install cmake llvm
    $ brew upgrade go python node
    $ pip3 install jedi
    $ npm install -g typescript

# 1. clone git repository

    $ git clone --recursive https://github.com/ycm-core/YouCompleteMe.git
    $ cd YouCompleteMe
    $ git submodule update --init --recursive

# 2. Compile YCM

    $ cd <YouCompleteMe>
    # Compiling YCM all in one
    $ python3 ./install.py --all
    # Compiling YCM without semantic support for C-family languages:
    $ python3 ./install.py
    # or Compiling YCM with semantic support for C-family languages through clangd:
    $ python3 ./install.py --clangd-completer
    # add --ts-completer, --go-completer, --rust-completer

done.

# 3. download the latest version of libclang, can be skipped on macOS

url: http://llvm.org/releases/download.html

# 4. Compile the ycm_core library that YCM needs. This library is the C++ engine that YCM uses to get fast completions.

$ sudo apt-get install cmake python-dev python3-dev
$ cd <YouCompleteMe>
$ export YCM=`pwd`

$ mkdir ~/ycm_build
$ cd ~/ycm_build
$ cmake -G "Unix Makefiles" -DUSE_SYSTEM_BOOST=ON -DUSE_SYSTEM_LIBCLANG=ON . $YCM/third_party/ycmd/cpp
$ cmake --build . --target ycm_core --config Release

>> [100%] Linking CXX shared library $YCM/third_party/ycmd/ycm_core.so

# 5. This step is optional.

Build the regex module for improved Unicode support and better performance with regular expressions. The procedure is similar to compiling the ycm_core library:

$ mkdir ~/regex_build
$ cd ~/regex_build
$ cmake -G "Unix Makefiles" . $YCM/third_party/ycmd/third_party/cregex
$ cmake --build . --target _regex --config Release

>> [100%] Linking C shared library $YCM/third_party/ycmd/third_party/cregex/regex_3/_regex.so

# 6. Set up support for additional languages: C#, Go, Node.js, Rust, Java

# 7. Install the binary

# Step 0.
    ycmd use mrab-regex instead of cregex, now we can skip compile regex step.
    But bitbucket.org is VERY slow! So, change mrab-regex repo to github

    $ vim $YCM/.git/modules/third_party/ycmd/config
      [submodule "third_party/mrab-regex"]
        active = true
    -   url = https://bitbucket.org/.../mrab-regex
    +   url = https://github.com/ycm-core/regex

# Step 1. get(clone/pull) the git repository

    $ git clone --recursive https://github.com/ycm-core/YouCompleteMe.git

    or,

    $ git clone https://github.com/ycm-core/YouCompleteMe.git
    # change mrab-regex repo to github
    $ vim $YCM/.git/modules/third_party/ycmd/config
    $ git submodule update --init --recursive

    $ cd $YCM
    $ git pull --recurse-submodules=yes
    $ cd third_party/ycmd
    $ git pull --recurse-submodules=yes

# Step 2. Compile the ycm_core library that YCM needs.
    echo Compile ycm_core library...
    cd $YCM/third_party/ycmd
    ./build.py
    # >> [100%] Linking CXX shared library $YCM/third_party/ycmd/ycm_core.so
    # >> [100%] Linking C shared library $YCM/third_party/cregex/regex_3/_regex.so

# Step 3. Install the binary, tern-completer for javascript

    $ cd $YCM
    $ ./install.py --clang-completer --tern-completer --skip-build

# python: jedi
let g:ycm_python_binary_path = '/usr/local/bin/python3'

# ruby: eclim
let g:EclimCompletionMethod = 'omnifunc'
:ProjectCreate <path-to-your-project> -n

create .tern-project in project folder

usage: build.py [-h] [--clang-completer] [--cs-completer] [--go-completer]
                [--rust-completer] [--java-completer] [--system-boost]
                [--system-libclang] [--msvc {14,15}] [--ninja] [--all]
                [--enable-coverage] [--enable-debug] [--build-dir BUILD_DIR]
                [--quiet] [--skip-build] [--no-regex] [--clang-tidy]
```

To make YCM not use Tab key, add two following lines to your .vimrc:

```
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
```

Don’t worry, you still be able to cycle through completion with <C-N> and <C-P> keys.

### Lang/syntax checking

[ale](
https://github.com/w0rp/ale
) - Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration

* to fix it:
    ale/ale_linters/python/vulture.vim +37
      -   \   ? ' .'
      +   \   ? ' *.py'



```
# add markdown parser: https://github.com/remarkjs/remark
$ npm install remark
$ npm install standard --global
$ npm install markdownlint remark-lint prettier

$ vim ~/.vimrc

let g:ale_linters = {
\   'javascript': ['standard'],
\}
let g:ale_fixers = {'javascript': ['standard']}
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
" modify flags given to html-beautify
" js-beautify, tidy/tidy-html5
let g:ale_html_beautify_options = ''
let g:ale_html_tidy_options = ''
```

### Lang/lang-special tools

#### web front end: html5/javascript/coffeescipt

[html5.vim](
https://github.com/othree/html5.vim
) - HTML5 omnicomplete and syntax

[vim-javascript](
https://github.com/pangloss/vim-javascript
) - Vastly improved Javascript indentation and syntax support in Vim.

[vim-vue](
https://github.com/posva/vim-vue
) - Syntax Highlight for Vue.js components

#### Ruby/Rails/Cucumber/RSpec, haml/erb/yaml

[vim-rails](
https://github.com/tpope/vim-rails
) - rails.vim: Ruby on Rails power tools

[vim-cucumber](
https://github.com/tpope/vim-cucumber
) - Vim Cucumber runtime files

[vim-yardoc](
https://github.com/noprompt/vim-yardoc
) - ruby documentation tool

vim-solargraph: vim auto-completion tool

- https://ruby-china.org/topics/37422
- https://github.com/rsense/rsense
- https://github.com/castwide/solargraph
- https://github.com/hackhowtofaq/vim-solargraph
- https://github.com/uplus/deoplete-solargraph
- https://github.com/whitequark/parser
- https://github.com/vim-ruby/vim-ruby
- https://github.com/danchoi/ri.vim

[How to Write a Vim Plugin With Ruby](https://phraseapp.com/blog/posts/writing-vim-plugin-ruby/)
[Extending Vim with Ruby](http://www.linux-mag.com/id/1027/)

#### Python

[pydoc](
https://github.com/fs111/pydoc.vim
) - Python documentation view- and search-tool (uses pydoc)

[vim-flake8](
https://github.com/nvie/vim-flake8
) - Flake8 plugin for Vim

[vim-python-pep8-indent](
https://github.com/Vimjas/vim-python-pep8-indent
) - A nicer Python indentation style for vim.

# Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box.
- https://github.com/python-mode/python-mode

#### Lang/markdown,xml,json,csv

[Vim-log4j](
https://github.com/tetsuo13/Vim-log4j
) - Syntax highlighting for log4j and log4php

[vim-json](
https://github.com/elzr/vim-json
) - A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
* When editing, :set conceallevel=0

[csv.vim](
https://github.com/chrisbra/csv.vim
) - A Filetype plugin for csv files

[vim-markdown](
https://github.com/tpope/vim-markdown
) - Vim Markdown runtime files

    let g:markdown_minlines = 200

[vim-instant-markdown](
https://github.com/suan/vim-instant-markdown
) - Instant Markdown previews from VIm!

    $ npm -g install instant-markdown-d

#### Markdown Wiki

[vim-markdown-wiki](
https://github.com/mmai/vim-markdown-wiki
) - Vim plugin wich eases links manipulation and navigation in markdown pages

> Markdown Resources:
> https://github.com/dense-analysis/ale/issues/1211
> https://github.com/shd101wyy/mume - Powerful markdown tool
> https://github.com/remarkjs/remark
> https://www.npmjs.com/package/remarkable
> https://www.npmjs.com/package/prettify-markdown

#### Markdown Preview for (Neo)vim

[markdown-preview.nvim](
https://github.com/iamcco/markdown-preview.nvim
) - Markdown Preview for (Neo)vim

Preview markdown on your modern browser with synchronised scrolling and flexible configuration

Main features:

- Cross platform (macos/linux/windows)
- Synchronised scrolling
- Fast asynchronous updates
- Katex for typesetting of math
- Plantuml
- Mermaid
- Chart.js
- sequence-diagrams
- flowchart
- dot
- Toc
- Emoji
- Task lists
- Local images
- Flexible configuration


* To install markdown-preview, goto work directory, then

    $ cd app
    $ yarn install

  then, open vim and type

    :call mkdp#util#install()

  done.

#### Dash/IME for macos

[dash.vim](
https://github.com/rizzatti/dash.vim
) - Search Dash.app from Vim

[vim-barbaric](
https://github.com/alanqian/vim-barbaric
) - Automatic input method switching for vim
  - fork from https://github.com/rlue/vim-barbaric
```
$ git clone https://github.com/myshov/xkbswitch-macosx
$ cp xkbswitch-macosx/bin/xkbswitch /usr/local/bin

let g:barbaric_default = 0
```


#### Omnifunc complete keywords

- keywords/cpp.txt
- keywords/js.txt

#### MyCoding - private settings, keywords complete, etc.

[vim-lang-customize](
https://github.com/alanqian/vim-lang-customize
) - private settings, keywords complete, etc.

ftplugin/cpp.vim
ftplugin/javascript.vim
ftplugin/make.vim
ftplugin/log.vim
ftplugin/python.vim
plugin/vim-cjk-format.vim

## Discarded Plugins

[deoplete.nvim](
 https://github.com/Shougo/deoplete.nvim
) - 🌠 Dark powered asynchronous completion framework for neovim/Vim8

[deoplete-flow](
 https://github.com/steelsojka/deoplete-flow
) - A plugin for deoplete to get flow autocompletion functionality.

[neocomplcache](
 https://github.com/Shougo/neocomplcache
) - Ultimate auto-completion system for Vim.

[supertab](
 https://github.com/ervandew/supertab
) - Perform all your vim insert mode completions with Tab

[jedi-vim](
 https://github.com/davidhalter/jedi-vim
) - Using the jedi autocompletion library for VIM. For python.

[vim-rake](
 https://github.com/tpope/vim-rake
) - rake.vim: it's like rails.vim without the rails

[vim-rspec](
 https://github.com/thoughtbot/vim-rspec
) - Run Rspec specs from Vim

[syntastic](
 https://github.com/vim-syntastic/syntastic
) - Syntax checking hacks for vim

[snipmate.vim](
 https://github.com/msanders/snipmate.vim
) - snipMate.vim aims to be a concise vim script that implements some of TextMate's snippets features in Vim.

[vim-autoformat](
 https://github.com/Chiel92/vim-autoformat
) - Provide easy code formatting in Vim by integrating existing code formatters.
