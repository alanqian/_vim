:help tags
:help ctags
:help cscope
:help tagbar
:help mark-motions
:help folding
:help :YcmCompleter
:help Ultisnips

https://github.com/lldb-tools/vim-lldb

    :call CTags()
    :ta {symbol} " CTRL-], 
    :tn
    :tp
    :tags

    $ cd ${proj-dir}
    $ cscope-mk.sh
    USAGE	:cs find {querytype} {name}

    {querytype} corresponds to the actual cscope line
    interface numbers as well as default nvi commands:

    0 or s: Find this C symbol
    1 or g: Find this definition
    2 or d: Find functions called by this function
    3 or c: Find functions calling this function
    4 or t: Find this text string
    6 or e: Find this egrep pattern
    7 or f: Find this file
    8 or i: Find files #including this file

    map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
    command Goto...
