"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimrc - vim configuration file
" maintainer: qianguoxiang@qq.com
" version: 3.1 - Sep 24, 2018
" 
" => General UI
" => Files: encoding, backups, undo, last cursor position
" => Text: tab/indent/wrap related
" => Fonts, Colors and Highlights
" => search/grep in visual mode
" => Personal Key Mapping
" => Moving around, tabs and buffers
" => Spell checking, Abbrevs
" => filetypes
" => Cope
" => Omni complete functions
" => ctags and cscope
" => dictionary and translate
"""""
" => NERDTree and Tagbar
" -- vimgdb
" => Doxgen Toolkit
" => vim-templates
" => vim-test
" => html5.vim
" -- syntastic: configure syntax checking to check on open as well as save
" => ale: Asynchronous Lint Engine
" => YCM: YouCompleteMe
" => UltiSnips: The ultimate snippet solution for Vim
" => emmet-vim: Zen-coding for HTML and CSS 
" => jsdoc: Generate JSDoc to your JavaScript code.
" => Pydoc.vim - integrates Python documentation system into Vim.
" -- vim-autoformat: code formatters.
" => csv.vim
" => Personal Functions
"""""
" Personal settings: 
" ~/.vim/pack/plugins/start/MyCoding/plugin/vim-cjk-format.vim
" ~/.vim/pack/plugins/start/MyCoding/ftplugin/cpp.vim
" ~/.vim/pack/plugins/start/MyCoding/ftplugin/javascript.vim
" ~/.vim/pack/plugins/start/MyCoding/ftplugin/python.vim
" ~/.vim/pack/plugins/start/MyCoding/ftplugin/log.vim
" ~/.vim/pack/plugins/start/MyCoding/ftplugin/make.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
" get system
func! MySys()
  if has("unix")
    let s:uname = substitute(system("uname -s"), '\n\+$', '', '')
    if s:uname == "Darwin"
      return "macOS"
    else
      return "Linux"
    endif
  else
    return "Windows"
  endif
endfun

" => General UI
set nocompatible "use Vim settings, rather then Vi settings.
filetype plugin indent on

set history=512
set number

let mapleader = ","  " Leader
let g:mapleader = ","

"set showcmd      "display incomplete commands
set laststatus=2  "Always display the status line
set autowrite     "Automatically :write before running commands
set autoread      "Set to auto read when a file is changed from the outside

set scrolloff=4   "Set 4 lines to the curors - when moving vertical..
set wildmenu      "Turn on WiLd menu
set ruler         "Always show current position
set cmdheight=2   "The commandbar height
set hid           "Change buffer - without saving
set backspace=eol,start,indent "Set backspace config
set whichwrap+=<,>,h,l
set ignorecase    "Ignore case when searching
set smartcase
set hlsearch      "Highlight search things
set incsearch     "Make search act like search in modern browsers
set nolazyredraw  "Don't redraw while executing macros
set magic         "Set magic on, for regular expressions
set showmatch     "Show matching bracets when text indicator is over them
set mat=2         "How many tenths of a second to blink
set completeopt=longest,menu

set noerrorbells  "No sound on errors
set novisualbell
set t_vb=
set timeoutlen=1000

" => dvorak keyboard layout, but command in qwerty keyboard
" set keymap=dvorak
" or,
" set langmap='q,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,/[,=],aa,os,ed,uf,ig,dh,hj,tk,nl,s\\;,-',\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z/,[-,]=,\"Q,<W,>E,PR,YT,FY,GU,CI,RO,LP,?{,+},AA,OS,ED,UF,IG,DH,HJ,TK,NL,S:,_\",:Z,QX,JC,KV,XB,BN,MM,W<,V>,Z? 
" hjkl`~
" dhtn -> hjkl
" jkl -> dtn

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax enable
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" TO resize window splits, use Ctrl-w + ?
" resize height: <C-W> n[-|+]
" resize width: <C-W> n[>|<]
" all to equal dimensions: <C-W> =
" maximum height: <C-w> _
" maximum width: <C-W> |

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files: encoding, backups, undo, last cursor position

" File encoding
" :e ++enc=cp936 to reload file in cp936 encodings
set encoding=utf8  ",cp936
set fileencodings=utf-8,cp936,ucs-bom "Support files both in unicode & GBK
set termencoding=utf-8
set ffs=unix,mac,dos "Default file types
set wildignore=*.o,*.obj,*.a,*.lib,*.dll,*.exe
set formatoptions+=m " line break for Chinese 

" File backup/swapfile/undofile
set nobackup     " turn backup off, since most stuff is in SVN, git anyway...
set nowritebackup
set noswapfile
set noundofile
set vb t_vb=     " no visual bell & flash

" remeber last cursor position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exec("norm '\"")|else|exec "norm $"|endif|endif
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exec "normal g`\"" |
  \ endif

" trim trail space before save
func! TrimRight()
  exec "normal mz"
  %s/\s\+$//ge
  exec "normal `z"
endfunc

func! ClangFormat()
  exec "normal mz"
  :%!clang-format
  exec "normal `z"
endfunc

func! AutoPep8()
  exec "normal mz"
  :%!autopep8 -
  exec "normal `z"
endfunc

func! VueFormat()
  exec "normal mz"
  :%!vue-formatter
  exec "normal `z"
endfunc

command HexView1 :%!xxd -c 32 -g 1<cr>
command HexView2 :%!xxd -c 32 -g 2<cr>
command HexView4 :%!xxd -c 32 -g 4<cr>
command HexView8 :%!xxd -c 48 -g 8<cr>

func! PasteTmuxBuffer()
  exec ":r !tmux show-buffer"
endfunc
nmap <leader>y :call PasteTmuxBuffer()<cr>


augroup SPACEVIM_ASYNCRUN
  autocmd!
  " Automatically open the quickfix window
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

func AddSpec()
  let s:cur_file = expand('%')
  let s:spec_file = 'spec/' . substitute(substitute(s:cur_file, '^lib\/', '', ''), '\.rb$', '_spec.rb', '')
  echom system('rspec-scaffold ' . s:cur_file)
  execute 'edit' s:spec_file
endfunc

command SpecAdd call AddSpec()

" Quick run via <F5>
command Run call Runit()
nnoremap <F5> :call Runit()<CR>
func! Runit()
  exec 'w'
  if &filetype == 'c'
    exec "AsyncRun! gcc % -o %<; time ./%<"
  elseif &filetype == 'cpp'
    exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
  elseif &filetype == 'java'
    exec "AsyncRun! javac %; java %<"
  elseif &filetype == 'sh'
    exec "AsyncRun! bash %"
  elseif &filetype == 'python'
    exec "AsyncRun! python %"
  elseif &filetype == 'ruby'
    exec "AsyncRun! ruby %"
  elseif &filetype == 'coffee'
    exec "AsyncRun! coffee %"
  endif
endfunc


augroup vimrc_trim_right
  autocmd!
  " trim trail space before save
  "Delete trailing white space, useful for C/C++, Perl, Ruby, Python, etc
  autocmd bufwritepre *.h,*.c,*.hh,*.cc,*.hpp,*.cpp,*.hxx,*.cxx :call TrimRight()
  autocmd bufWritepre *.sh,*.pl,*.pm,*.rb,*.erb,*.haml,*.py,*.php,*.js,*.coffee :call TrimRight()
  autocmd bufWritepre *.vue,*.erb,*.haml :call TrimRight()
  autocmd bufWritepre *.xml,*.yml,*.json,*.sql :call TrimRight()
augroup END

func! Filter_win_build_log()
  %s/\\/\//g
  exec "normal gg"
  exec "normal /error\|warning"
endfunc

augroup build_log
  autocmd BufReadPost build.log :call Filter_win_build_log()
augroup END

"show c/c++ system include path
"$ echo "" | gcc -xc - -v -E
"default: path=.,/usr/include,,
set path+=,/usr/local/include,
"let autocomplete ignore boost 
set include=^\\s*#\\s*include\ \\(<boost/\\)\\@!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text: tab/indent/wrap related

set wildmode=full       " completion mode
set expandtab
set textwidth=86
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set noautoindent
set smartindent
set shiftround
set nowrap
"set linebreak
"set numberwidth=5

" folding: set default to unfold when open a file
" zo/zc/za, use zM to close all folding
set foldmethod=indent "syntax
set foldlevel=0
autocmd BufRead * normal zR
" map fold at here
func FoldAtHere()
  let &l:foldlevel = indent('.') / &shiftwidth
endfunc
nnoremap <silent> <leader>z :call FoldAtHere()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fonts, Colors and Highlights

" Set font according to system
"guifont/guifontwide setting
"set gfn=JetBrains\ Mono:h14
"set gfn=Fira\ Code:h14
"set gfn=Melno:h14
"set gfn=Monaco:h14
"set gfn=DejaVu\ Sans\ Mono:h14
"set gfn=Ubuntu\ Mono:h14
"set gfn=Monospace:h14
"---
"
"set gfw=Droid\ Sans\ Fallback:h15 " GB18030, bigger than gfn
"set gfw=PingFang\ SC\ Light:h15 " GB18030, bigger than gfn
"set gfw=PingFang\ SC:h15 " GB18030, bigger than gfn
"set gfw=Alibaba\ PuHuiTi\ Light:h15 " GB18030?
"set gfw=Alibaba\ PuHuiTi:h15 " GB18030?
"set gfw=STSong:h14 " GB18030
"set gfw=STZhongSong:h15 " GBK,20902
"set gfw=STXiHei:h15 " GBK,20902, bigger than gfn
if MySys() == "macOS"
  set gfn=JetBrains\ Mono:h14 " Melno:h14
  "set gfw=PingFang\ SC:h15 " GB18030, bigger than gfn
  set gfw=Alibaba\ PuHuiTi:h15 " GB18030?
  set shell=/bin/bash
  let g:resolution=system('system_profiler SPDisplaysDataType | grep Resolution | sed -E -e "s/ +/:/g" | cut -d ":" -f4,6')[:-2]
elseif MySys() == "Windows"
  let g:resolution='1280:800'
  set gfn=Monaco:h12
  set gfw=STXiHei:h15 " GBK,20902, bigger than gfn
elseif MySys() == "Linux"
  let g:resolution='1280:800'
  set gfn=Monospace\ 12
  set gfw=STXiHei\ 15 " GBK,20902
  set shell=/bin/bash
endif

" color scheme
if has("gui_running")
  set guioptions-=T
  if g:resolution == '3840:2160'
    " for 4K monitor: 3840x2160
    set linespace=3  " for Chinese ideograph
    set lines=54 columns=210
  endif
  set nomousehide
  winpos 110 23
  set t_Co=256 " colors
  set background=dark
  "imap <C-S-V> <ESC>l"+gPi
  "nmap <C-S-V> l"+gPi
  :let g:colorscheme_switcher_exclude = ['blue', 'default', 'delek', 'morning', 'peachpuff', 'zellner']
  colorscheme darkblue " vividchalk
else
  set t_Co=8 " colors
  set background=dark
  " Hide the mouse pointer while typing
  set mousehide
  :let g:colorscheme_switcher_exclude = ['blue', 'default', 'delek', 'evening', 'peachpuff', 'morning', 'shine']
  colorscheme koehler " industry
endif

" customized highlights
hi TabLine term=standout cterm=standout ctermfg=0 ctermbg=7
hi def link yamlKeyValueDelimiter        Operator

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => search/grep in visual mode

" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

func! CmdLine(str)
  exec "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunc

" From an idea by Michael Naumann
func! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mapping

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
nmap <leader>rc :tabe! ~/.vim/vimrc<cr>
nmap <leader>ww :tabe! ~/vimwiki/personal.wiki<cr>
map <leader>pp :setlocal invpaste!<cr>

" Useful with Chinese IME, replaced by vim-auto-ime.vim
" : / * # ^ $ < >
"
nmap <silent> <C-3> <Plug>(pydocstring)

" Tab configuration
map <leader>e :tabe

" bash like keys for the command line
cnoremap <C-A>		  <Home>
cnoremap <C-E>		  <End>
cnoremap <C-P>      <Up>
cnoremap <C-N>      <Down>
cnoremap <S-Insert> <C-R>

" bash like keys for quick edit
inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-F> <C-Right>
inoremap <C-B> <C-Left>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" insert C++ comment
noremap <C-\> <Esc>^i// <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers

func! GoNextMethod()
  if &filetype == 'ruby' || &filetype == 'java' || &filetype == 'python'
    exec "normal ]m"
  else
    exec "normal ]]"
  endif
endfunc

func! GoPrevMethod()
  if &filetype == 'ruby' || &filetype == 'java' || &filetype == 'python'
    exec "normal [m"
  else
    exec "normal [["
  endif
endfunc

" Map space to next/prev method
nmap <silent> <Space> :call GoNextMethod()<cr>
nmap <silent> <C-Space> :call GoPrevMethod()<cr>
vmap <silent> <Space> :call GoNextMethod()<cr>
vmap <silent> <C-Space> :call GoPrevMethod()<cr>

" hide search highlightings
nmap <silent> <leader>/ :let @/=''<cr>
nmap <silent> <leader>? :%s///gn<cr>

"set cursorline
nnoremap <C-N> :set invcursorline<CR>

" Open new split panes to right/bottom, which feels more natural
set splitbelow
set splitright

" Smart way to move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>
nmap <Down> [M
nmap <Up> ]M

" Tab configuration
map <leader>e :tabe
"switch between TABs
set switchbuf=useopen,usetab,newtab
nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabN<CR>
"nmap <C-Tab> :bnext<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

"map <leader>tn :tabnew<cr>
"map <leader>te :tabedit
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

"Move a line of text using Comamnd+[jk] on mac, for macvim only
"<D-?> Command, "<M-?> ALT
if MySys() == "macOS"
  nmap <M-j> mz:m+<cr>`z
  nmap <M-k> mz:m-2<cr>`z
  vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
  vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
endif

if MySys() == "Linux"
  " gnome-terminal bugs for Shift-F1 ~ Shift-F4
  map <Esc>O1;2P <S-F1>
  map <Esc>O1;2Q <S-F2>
  map <Esc>O1;2R <S-F3>
  map <Esc>O1;2S <S-F4>
  map <Esc>O1;5P <C-F1>
  map <Esc>O1;5Q <C-F2>
  map <Esc>O1;5R <C-F3>
  map <Esc>O1;5S <C-F4>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking, Abbrevs

"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
"set spellfile=$HOME/.vim-spell-en.utf-8.add

" general abbrevs

"iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%b %d, %Y")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => filetypes
augroup vimrc_filetypes
  autocmd!

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.h,*.hh,*.hpp,*.hxx,*.inl,*.cc,*.cpp,*.cxx set filetype=cpp
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Automatically wrap at 80 characters for Markdown, gfw=STZhongSong:h15
  autocmd FileType markdown setlocal textwidth=80 linespace=5 nospell wrap
  " autocmd FileType markdown setlocal formatprg=? equalprg=?

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72 spell

  autocmd FileType cpp setlocal shiftwidth=4
  " http://vimdoc.sourceforge.net/htmldoc/indent.html#cinoptions-values
  autocmd FileType cpp setlocal cinoptions=:0,l1,g0.5s,h0.5s,t0,i1.5s,+1.5s,(0,w1,W1.5s,)8
  "h1,l1,g1,t0,i4,+4,(0,w1,W4 )

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " pretty format for xml file with xmllint
  " to recover utf8, use
  " :%!xmllint --format --recover --encode utf8 -
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --encode\ utf8\ -\ 2>/dev/null

  autocmd FileType ruby setlocal makeprg=rake

  " set omni complete keywords, CTRL-P or CTRL-N
  autocmd FileType javascript setlocal complete+=k~/../dotfiles/_vim/keywords/js.txt
  autocmd FileType cpp setlocal complete+=k~/../dotfiles/_vim/keywords/cpp.txt

  " python: for indent line starts with # 
  autocmd BufReadPost *.py inoremap # X#
  autocmd BufReadPost *.txt setlocal wrap
  autocmd BufReadPost *.log setlocal wrap
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope

" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>
map <F4> :lnext<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" 1. Whole lines                                |i_CTRL-X_CTRL-L|
" 2. keywords in the current file               |i_CTRL-X_CTRL-N|
" 3. keywords in 'dictionary'                   |i_CTRL-X_CTRL-K|
" 4. keywords in 'thesaurus', thesaurus-style   |i_CTRL-X_CTRL-T|
" 5. keywords in the current and included files |i_CTRL-X_CTRL-I|
" 6. tags                                       |i_CTRL-X_CTRL-]|
" 7. file names                                 |i_CTRL-X_CTRL-F|
" 8. definitions or macros                      |i_CTRL-X_CTRL-D|
" 9. Vim command-line                           |i_CTRL-X_CTRL-V|
"10. User defined completion                    |i_CTRL-X_CTRL-U|
"11. omni completion                            |i_CTRL-X_CTRL-O|
"12. Spelling suggestions                       |i_CTRL-X_s|
"13. keywords in 'complete'                     |i_CTRL-N|

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C/C++ Code Navigation:
" ctags + cscope + NerdTree + tagbar

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags

set tags=~/.tags
set tags+=~/.TAGS
set tags+=.tags
set tags+=../.tags

func! CTags()
  exec "normal mz"
  " exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
  :!ctags -f .tags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q --exclude=.svn . && cscope -bkq *.h *.cpp<CR>
  " index ctags from any project
  ":!ctags -R .<CR>
  exec "normal `z"
endfunc

" cscope
if has("cscope")
  "set csprg=/usr/bin/cscope
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set cscopetag
  set csto=1
  set nocsverb
  " add any database in dirs
  for f in [ './cscope.out', './.cscope.out', '../cscope.out', '../.cscope.out', '../../cscope.out', '../../.cscope.out']
    if filereadable(f)
      execute 'cs add ' . f . ' ~/work/' . g:project
      set csverb
      break
    endif
  endfor
  " 0 or s: Find this C symbol
  nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  " 1 or g: Find this definition
  nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  " 2 or d: Find functions called by this function
  nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
  " 3 or c: Find functions calling this function
  nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  " 4 or t: Find this text string
  nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  " 6 or e: Find this egrep pattern
  nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  " 7 or f: Find this file
  nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  " 8 or i: Find files #including this file
  nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

  " <leader>cs: Find this definition
  nmap <leader>cs :cs find g 
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => dictionary and translate
" stardict or macOS Dictionary
func! LookupDict()
  let l:the_word = expand("<cword>")
  if MySys() == "macOS"
    let f=system('say '. l:the_word)
    echo system('open dict://' . l:the_word)
  elseif MySys() == "Linux"
    let expl=system('sdcv -n ' . l:the_word)
    windo if expand("%") == "diCt-tmp" | q! | endif
    35vsp diCt-tmp
    setlocal buftype=nofile bufhidden=hide noswapfile
    1s/^/\=expl/
    1
  endif
endfunc
nmap <leader>f :call LookupDict()<CR>

" todo: 
" | paste -s -d ' ' - | trans :zh -b
func! Translate()
  " s:get_visual_selection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let text = join(lines, ' ')
  "let zh_text = system('trans :zh -b ' . "'" . text . "'")
  "call append(line("'>"), zh_text)
  normal Vo
  call append(line("'>"), 'foo')
endfunc
" vmap <Leader>tt :'<,'>call Translate()<CR>

" vim-barbaric : macos IME auto-switcher, set g:barbaric_local to pinyin
" show keyboard string layout: 
"   xkbswitch -g -e
let g:barbaric_default = 'US'
let g:barbaric_local = 5 " Since sougo pinyin without layout name
let g:barbaric_timeout = 20 "seconds

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree and Tagbar

let g:tagbar_ctags_bin = 'ctags'
"let tagbar_left=1
let g:tagbar_width = 30
let g:tagbar_compact=1
" configuration for c++: 
" kinds: {short}:{long}[:{fold}[:{stl}]]
" 'l:local:0:1',
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

"map <Leader>tt :TagbarToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-t>t :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -- vimgdb

" let g:vimgdb_can_loaded=1
" let g:vimgdb_debug_file = ""
"
" func! <SID>StartVIMGDB()
"   if g:vimgdb_can_loaded
"     let g:vimgdb_can_loaded= 0
"     run macros/gdb_mappings.vim
"   else
"     echo "the gdb is running...."
"   endif
" endfunc
"
" nmap <F6> :call <SID>StartVIMGDB()<CR><C-C><C-C> tbreak<CR> run<CR>
" nmap <C-F6> :call <SID>StartVIMGDB()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Doxgen Toolkit
" using :Dox command to add doxygen comment
let g:DoxygenToolkit_commentType="C++"
let g:DoxygenToolkit_authorName="alanqian, qian.guoxiang@qq.com"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_brifTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param[in] "
let g:DoxygenToolkit_returnTag="@return "
let g:DoxygenToolkit_versionString="1.0"
let g:doxygen_enhanced_color=1
let g:DoxygenToolkit_endCommentTag="//////////////////////////////////////////////////////"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pydocstring
let g:pydocstring_doq_path = '/usr/local/bin/doq'
let g:pydocstring_formatter = 'google'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-templates
let g:email = "qian.guoxiang@qq.com"
let g:project = "the-project"
let g:templates_directory = $HOME . '../dots/vim/templates'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-rspec: replaced by vim-test

" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>
" nnoremap <Leader>r :RunInInteractiveShell<space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-test

" make test commands execute using dispatch.vim
let test#strategy = "asyncrun"

" Runs the test nearest to the cursor in a test file
nnoremap <Leader>tt :TestNearest<CR>
" Runs all tests in the current test file or in the last file
nnoremap <Leader>tf :TestFile<CR>
" Runs the whole test suite
nnoremap <Leader>ts :TestSuite<CR>
" Runs the last test
nnoremap <Leader>tl :TestLast<CR>
" Visits the test file from which you last run your tests
nnoremap <Leader>tv :TestVisit<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => html5.vim: Treat <li> and <p> tags like the block tags they are

let g:html_indent_tags = 'li\|p'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -- syntastic: configure syntax checking to check on open as well as save
"let g:syntastic_check_on_open=1
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
"let g:syntastic_cpp_include_dirs=['/usr/local/include', '/opt/local/include', '/usr/include/c++/4.8.4', '../include', '../src']
"let g:syntastic_python_checker=['flake8']
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown-wiki: revised wiki page title as '# ' style
function! MdwiWriteTitle(word)
  return 'normal!\ a# '.escape(a:word, ' \').'\<esc>o'.'\<esc>o'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview.nvim - Markdown Preview for (Neo)vim

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ale: Asynchronous Lint Engine
" https://github.com/w0rp/ale
let g:ale_linters = {}
let g:ale_fixers = {}
"""
let g:ale_linters.c = ['clang-format']
let g:ale_linters.cpp = ['clang-format']
let g:ale_fixers.cpp = ['clang-format']
"let g:ale_c_clangformat_options = '-I../include'
let g:ale_linters.python = ['flake8', 'pylint', 'pydocstyle', 'vulture']
"let g:ale_linters.python = ['flake8', 'pylint', 'pydocstyle']
let g:ale_fixers.python = ['autopep8']
"let g:ale_python_pylint_options = '--rcfile ~/.vim/_pylintrc_google'
let g:ale_linters.ruby = ['rubocop']
let g:ale_fixers.ruby = ['rubocop']
"""
" javascript: npm install -g eslint eslint-plugin-html eslint-plugin-vue standard stylelint prettier fixjson jsonlint
" standard --plugin html '**/*.{js,vue}'
" html: brew install tidy-html5
let g:ale_linters.javascript = ['standard'] " ['eslint']
let g:ale_fixers.javascript = ['standard'] " ['prettier', 'eslint']
let g:ale_linters.vue = ['eslint']
let g:ale_fixers.vue = ['eslint']
let g:ale_linters.css = ['stylelint']
let g:ale_fixers.css = ['stylelint', 'prettier']
let g:ale_linters.sass = ['sasslint']
let g:ale_linters.scss = ['scsslint']
let g:ale_linters.xml = ['xmllint']
let g:ale_fixers.xml = ['xmllint']
let g:ale_xml_xmllint_options = '--encode utf8'
let g:ale_linters.html = []
let g:ale_fixers.html = ['tidy']
let g:ale_html_tidy_options = '-q -e -i'
let g:ale_linters.haml = ['haml-lint']
let g:ale_linters.json = ['jsonlint']
let g:ale_fixers.json = ['fixjson', 'prettier']
let g:ale_linters.markdown= ['markdownlint']
let g:ale_fixers.markdown= ['prettier']
"""
" yaml: 
let g:ale_linters.yaml = ['yamllint']
let g:ale_fixers.yaml = ['prettier']
" markdown: npm install -g remark markdownlint
let g:ale_linters.markdown = ['markdownlint']
let g:ale_fixers.markdown = ['prettier', 'remark'] 
"""
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_fix_on_save = 0  " DO NOT run ale_fixer on save

" create a convenient alias for ALEFix, ALELint
command Format ALEFix
command Lint ALELint

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YCM: YouCompleteMe
" YcmToggleLogs, YcmDebugInfo, YcmDiags
let g:ycm_python_binary_path = '/usr/local/bin/python3'
"let g:ycm_server_python_interpreter=$HOME.'/.pyenv/shims/python3'
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist = {
      \ 'markdown': 1,
      \ 'text': 1,
      \ 'vim': 1,
      \ 'vimwiki': 1,
      \ 'log': 1,
      \}
" assign shortcut key for GoToDefinition, etc.
nnoremap <leader>gg :YcmCompleter GoTo<CR>
nnoremap <leader>gv :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gm :YcmCompleter GoToImplementationElseDeclaration<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gD :YcmCompleter GoToDefinition<CR>
command GotoVariable :YcmCompleter GoToDefinitionElseDeclaration
command GotoMethod :YcmCompleter GoToImplementationElseDeclaration
command GotoInclude :YcmCompleter GoToInclude
command GotoDeclaration :YcmCompleter GoToDeclaration
command GotoDefinition :YcmCompleter GoToDefinition
command GotoReferences :YcmCompleter GoToReferences
command GoToImplementation :YcmCompleter GoToImplementation


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UltiSnips: The ultimate snippet solution for Vim
let g:UltiSnipsSnippetDirectories=[] " ignore snippets in ./UltiSnips
let g:UltiSnipsExpandTrigger='<c-l>' " <tab> for YCM
"let g:UltiSnipsListSnippets='<c-tab>'
"let g:UltiSnipsJumpForwardTrigger='<c-j>'
"let g:UltiSnipsJumpBackwardTrigger='<c-k>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => emmet-vim: Zen-coding for HTML and CSS 

let g:user_emmet_install_global = 1
"let g:user_emmet_leader_key = <C-y>

" p#foo.bar => <p id="foo" class="bar">
"let g:user_emmet_expandabbr_key = '<C-y>,'
let g:user_emmet_expandabbr_key = '<C-y>k'  

" foo => <foo>@</foo>
"let g:user_emmet_expandword_key = '<C-y>;'
let g:user_emmet_expandword_key = '<C-y>w'  

" emmet-wrap-with-abbreviation *v_<C-y>,*

" <foo></foo> => <foo class="k" id="bar"></foo>
"let g:user_emmet_update_tag = '<C-y>u'

"let g:user_emmet_balancetaginward_key = '<C-y>d'
"let g:user_emmet_balancetagoutward_key = '<C-y>D'
"let g:user_emmet_next_key = '<C-y>n'
"let g:user_emmet_prev_key = '<C-y>N'
"let g:user_emmet_imagesize_key = '<C-y>i'
"let g:user_emmet_togglecomment_key = '<C-y>/'
"let g:user_emmet_splitjointag_key = '<C-y>j'
"let g:user_emmet_removetag_key = '<C-y>k'
let g:user_emmet_removetag_key = '<C-y>x'
"let g:user_emmet_anchorizeurl_key = '<C-y>a'
"let g:user_emmet_anchorizesummary_key = '<C-y>A'
"let g:user_emmet_mergelines_key = '<C-y>m'
"let g:user_emmet_codepretty_key = '<C-y>c'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => jsdoc: Generate JSDoc to your JavaScript code.
let g:jsdoc_enable_es6 = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pydoc.vim - integrates Python documentation system into Vim.
let g:pydoc_open_cmd = 'sp'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -- vim-autoformat: code formatters.
" https://github.com/Chiel92/vim-autoformat
" :Autoformat<CR>
"let g:formatter_yapf_style = 'pep8'
"let g:formatters_python = ['yapf']
"let g:formatters_cpp = ['clangformat']
"let g:formatters_c = ['clangformat']
"let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; eslint --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
"let g:formatters_javascript = ['eslint']
"let g:formatdef_yapf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <Tab>: insert tab or completion? whether at beginning of line,
func! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunc
"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <S-Tab> <c-n>

"free markdown from vimwiki plugin for snipmate, tab completion
let g:vimwiki_ext2syntax = {}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => csv.vim
let g:csv_highlight_column = 'y'
let b:csv_headerline = 0
hi link CSVColumnOdd Normal
hi link CSVColumnEven Comment
" :%ArrangeColumn
" :%Header 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Personal Functions

" Save list of buffers 
func! SaveBufferList()
  let buffers = "cd " . getcwd() . "\n\n" 
  let buffers .= '" load files to buffer' . "\n" 
  let saved_buffers = 0
  let curr_buffer = bufnr("%")
  let rng = range(1, bufnr('$'))
  for i in rng
    if buflisted(i) && bufname(i) != ''
      execute 'b ' . i
      let buffers .= 'badd +' . line('.') . ' ' . bufname(i) . "\n"
      let saved_buffers += 1
    endif
  endfor
  execute 'b ' . curr_buffer
  if saved_buffers > 0
    let buffer_count_str = saved_buffers . ' buffer'
    if saved_buffers > 1
      let buffer_count_str .= 's'
    endif

    let buffers .= "\n"
    let buffers .= "\" close current view if new buffer\n"
    let buffers .= "if bufname('%') == '' && line('$') == 1 && getline(1) == '' \n"
    let buffers .= "  bdel!\n" 
    let buffers .= "endif\n\n" 
    let buffers .= "echo '" . buffer_count_str . " restored'\n" 

    " save to a _vimbuffers in current directory
    new
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
    put=buffers
    execute 'w! _vimbuffers' 
    q
    echo buffer_count_str . " saved"
  else
    echo 'No buffers saved!'
  endif
endfunc
nmap <F10> :call SaveBufferList()<cr>

" vimdiff: vertical diffs, next/prev 
set diffopt+=vertical       " Always use vertical diffs
if &diff
  nnoremap <Space> ]c
  nnoremap <M-Space> [c
  nnoremap <Down> ]c
  nnoremap <Up> [c
  nnoremap <leader>p :diffput
  nnoremap <leader>g :diffget
  colorscheme slate  " peachpuff, ron, slate
endif

"""" Load local config: .vimrc, _vimrc """"
" Project-based local config .vimrc sample
" let g:project = "foo"
" set path+='/opt/local/include,./include,./src,'
" set wildignore+='*/tmp/*,build/*,bin/*,'
func! LoadLocalVimrc()
  let pdir = getcwd()
  if match(pdir, $HOME) != 0  " only for directories under HOME
    return
  endif
  while pdir != $HOME
    let local_rc = pdir . '/.vimrc'
    if filereadable(local_rc)
      execute 'source ' . local_rc
      break
    end
    let local_rc = pdir . '/_vimrc'
    if filereadable(local_rc)
      execute 'source ' . local_rc
      break
    end
    " back to parent directory
    let pdir = fnamemodify(pdir, ':h')
  endwhile
endfunc 
call LoadLocalVimrc()

" Fast editing of the GTD.md, .vimrc
nmap <leader>td :vsp ~/work/GTD.md<cr>
nmap <leader>tD :tabe! ~/work/GTD.md<cr>:lcd ~/work/memo/<cr>
" set working directory as current file 
nmap <leader>cd :lcd %:p:h<cr>
"""end of vimrc"""
