""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration file.
"
" Copyright (c) 2018 takeno2020. All Rights Reserved.
"
" Maintainer: takeno2020 <takeno2020@163.com>
"    Created: 2018-10-17
" LastChange: 2018-11-29
" Description:配置文件需要安装vim插件
"             1. sudo apt-get install vim vim-scripts vim-doc；
"             2. 生成索引：sudo apt-get install universal-ctags
"                如果是查看linux内核那么在内核目录下的script目录下有tags.sh脚本
"                可以生成对应架构的tags文件：make tags ARCH=arm
"             3. sudo apt-get install cscope
"             4. Source Explorer、NERD Tree、Tag List插件解压到.vim目录下面；
"             5. vim管理插件(一般在1完成后会安装)：
"                - sudo apt-get install vim-addon-manager
"                - 查看插件及状态 vim-addons status
"                - 使用：vim-addons install xxx   其中xxx为要安装的插件名；
"             6. 自动补全 - OmniCppComplete
"                - vim-addons install omnicppcomplete
"             7. echofunc - 当你在vim插入(insert)模式下紧接着函数名后输入一个
"                "("的时候,这个函数的声明就会自动显示在命令行中。如果这个函数
"                有多个声明,则可以通过按键"Alt+-"和"Alt+="向前和向后翻页,
"                这两个键可以通过设置g:EchoFuncKeyNext和g:EchoFuncKeyPrev参数
"                来修改。这个插件需要tags文件的支持,并且在创建tags文件的时候
"                要加选项"--fields=+lS"（OmniCppComplete创建的tag文件也能用）,
"                整个创建tags文件的命令如下: ctags -R --fields=+lS
"             8. 文件浏览器和缓冲区管理器WinManager
"                vim-addons install winmanager
"             9. buffer管理器MiniBufferExplorer
"                vim-addons install minibufexplorer
"            10. 代码折叠fold - 不用安装
"            11. 项目目录数管理器Project
"                - 用来显示项目的目录树，该目录树默认保存在~/.vimprojects文件中.
"                - vim-addons install project
"            12. quickfix命令集
"                - 通过quickfix命令集，你可在Vim内编译程序并直接跳转到出错位置
"                - 进行修正, 你可以接着重新编译并做修正，直到不再出错为止;
"            13. c-support 在.vim中解压安装.
"            14. vim gdb:将宏文件放入macros/gdb_mappings.vim中;
"            15. lookupfile插件：安装直接解压zip包到.vim目录。
"                需要以来genutils插件.
"            16. snipMate插件:解压安装
" Sections:
"   General Setting
"   Colors and Fonts
" Plugins Included:
"   bufexplorer - Makes it easy to switch between buffers
"       info -> :help bufExplorer
" Revisions:
"   v0.1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settiongs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" multi-endoding setting
""""""""""""""""""""""""

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'. Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

if has("multi_byte")
	" set bomb
	set fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk,big5,euc-jp,euc-kr
	set encoding=utf8
	
	" CJK environment detection and corresponding setting
	if v:lang =~ "^zh_CN"
		" Use cp936 to support GBK, euc-cn == gb2312
		set encoding=cp936
		set termencoding=cp936
		set fileencoding=cp936
	elseif v:lang =~ "^zh_TW"
		" cp950, big5 or euc-tw
		" Are they equal to each other?
		set encoding=big5
		set termencoding=big5
		set fileencoding=big5
	elseif v:lang =~ "^ko"
		" Copied from someone's dotfile, untested
		set encoding=euc-kr
		set termencoding=euc-kr
		set fileencoding=euc-kr
	elseif v:lang =~ "^ja_JP"
		" Copied from someone's dotfile, untested
		set encoding=euc-jp
		set termencoding=euc-jp
		set fileencoding=euc-jp
	endif
	" Detect UTF-8 locale, and replace CJK setting if needed
	if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
		set encoding=utf-8
		set termencoding=utf-8
		set fileencoding=utf-8
	endif
else
	echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

" 只有在“encoding”和“utf-8”或别的Unicode编码时才有效.告诉Vim怎么处理东亚二义性
" 宽度字符类,默认值为single - 使用和US-ASCII字符相同的宽度.
if exists("&ambiwidth")
	set ambiwidth=double
endif

" 定义当前的操作系统, 使用不同的系统时返回值可以为 “win32″ / “unix”/ “mac”
" 在Unix和类Unix操作系统中使用 “bash” 作为 “shell”;如果是在windows下使用cygwin,
" 则修改为cynwin的路径.
function! MySys()
	return "unix"
endfunction

if MySys() == "unix" || MySys() == "mac" 
	set shell=bash
else
	set shell=C:cygwininsh 
endif

" install Vundle bundles
""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Highlighting, Colors and Fonts
""""""""""""""""""""""""""""""""

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
syntax on " 语法高亮
endif
" color mycolor       " 自定义的配色方案,与下面的选择一种配置即可
" colorscheme ron       " elflord ron peachpuff default 设置配色方案，
                      " vim自带的配色方案保存在/usr/share/vim/vim73/colors目录下

" Detecting file type, Indentation and Alignment
""""""""""""""""""""""""""""""""""""""""""""""""

" have Vim load indentation rules and plugins according to the detected filetype
filetype plugin indent on " 启动自动补全
filetype on           " 检测文件类型
filetype indent on    " 针对不同的文件类型采用不同的缩进格式
filetype plugin on    " 允许插件

" If using a dark backgroud within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Restore the last quit position when open file.
if has("autocmd")
au BufReadPost * 
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" | endif
endif

" auto expand tab to blanks; autocmd FileType c,cpp set expandtab
set expandtab			   " 缩进用空格来表示，noexpandtab用制表符表示一个缩进;
set tabstop=4              " 设置制表符(tab键)的宽度.
set softtabstop=4          " 设置软制表符的宽度,回退时回退到缩进的长度.
set shiftwidth=4           " (自动) 缩进使用4个空格.
" set cindent                " 使用 C/C++ 语言的自动缩进方式.
" 设置C/C++语言的具体缩进方式
" set cinoptions={0,1s,t0,n,p2s,(04s,=.5s,>1s,=1s,:1s
set backspace=indent,eol,start
" set backspace=2          " 设置退格键可用
set autoindent             " 设置自动对齐(缩进)：即每行的缩进值与上一行相等;
                             " 使用noautoindent取消设置.
                             " set smartindent " 智能对齐方式.

" Search and Backup
"""""""""""""""""""

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set ignorecase             " 搜索模式里忽略大小写
set smartcase              " 如果搜索模式包含大写字符，不使用ignorecase选项。
                           " 只有在输入搜索模式并且打开ignorecase选项时才会使用.
set autoread
set autowrite              " 自动把内容写回文件: 如果文件被修改过，在每个 
                             " :next、:rewind、:last、:first、:previous、:stop、
							 " :suspend、:tag、:!、:make、CTRL-] 和 CTRL-^
							 " 命令时进行；用 :buffer、CTRL-O、CTRL-I、'{A-Z0-9}
							 " 或 `{A-Z0-9} 命令转到别的文件时亦然.
set showmatch              " 设置匹配模式，显示匹配的括号
set incsearch              " 输入字符串就显示匹配点
set hlsearch

" Text and Line setting
"""""""""""""""""""""""

set textwidth=80
set nowrap                 " 指定不折行. 
                             " 如果一行超过屏幕宽度,则向右边延伸到屏幕外面.
                             " 如果使用图形界面的话，指定不折行视觉效果会好得多.
set whichwrap=h,l          " 缺省情况下，h和l命令不会把光标移出当前行。
                             " 如果已经到了行首，无论按多少次h键，光标
                             " 始终停留在行首，l命令也类似,如果希望移出当前行则
                             " 使用这个设置
set linebreak              " 整词换行
set whichwrap=b,s,<,>,[,]  " 光标从行首和行末时可以跳到另一行去
" set hidden               " Hide buffers when they are abandoned
set mouse=a                " Enable mouse usage (all modes) "使用鼠标
set number                 " Enable line number "显示行号
" set previewwindow        " 标识预览窗口
set history=50             " set command history to 50.
" scrolloff/so 缺省为0,设置光标上下两侧最少保留的屏幕行数
set so=1
" set relativenumber number  " 相对行号，可用Ctrl+n在相对/绝对行号间切换
" set cursorcolumn           " 突出显示当前列，可使用Ctrl+m切换是否显示
" set cursorline             " 突出显示当前行，可使用Ctrl+m切换是否显示

" Turn backup off, since most stuff is in SVN, git anyway...
set nowb                   " 设置无备份文件
set noswapfile
set nobackup               " 取消备份

" status bar setting
""""""""""""""""""""

set laststatus=2           " 总显示最后一个窗口的状态行;
                             " 设为1则窗口数多于一时显示最后一个窗口的状态行;
						     " 0不显示最后一个窗口的状态行
set ruler                  " 标尺，用于显示光标位置的行号和列号，逗号分隔;      
                             " 每个窗口都有自己的标尺,如果窗口有状态行;
							 " 标尺在那里显示;否则,它显示在屏幕的最后一行上.

" Command line setting
""""""""""""""""""""""

set showcmd                " 显示输入的命令
set cmdheight=1
set showmode               " 显示vim的当前模式

" Shortcut and Fast saving setting
""""""""""""""""""""""""""""""""""

let mapleader=","

" space to command mode
nnoremap <space> :
vnoremap <space> :

" Fast saving
nmap <leader>w :w!<cr>

" Other settings
""""""""""""""""

set helpheight=10
set helplang=cn
set pumheight=10           " 设置弹出菜单的高度
set shell=/bin/bash

" autocmd! bufwritepost _vimrc source %     " vimrc文件修改之后自动加载(windows)
" autocmd! bufwritepost .vimrc source %     " vimrc文件修改之后自动加载（linux)
set shortmess=atI                           " 启动不显示援助索马里儿童提示
" 退出vim后，内容显示在终端屏幕 设置 退出vim后，内容显示在终端屏幕, 可以用于
" 查看和复制好处：误删什么的，如果以前屏幕打开，可以找回
" set t_ti= t_te=



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配置omnicppcomplete
" Description:
"	OmniCppComplete是基于ctags生成的索引信息来实现自动补全的，所以在ctags -R生成
"	tags时还需要一些额外的选项，这样生成的tags文件才能与OmniCppComplete配合运作,
"	即：ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
"	其中：
"	     --c++-kinds=+p  : 为C++文件增加函数原型的标签
"	     --fields=+iaS   : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、
"	                       以及函数的指纹(S)
"        --extra=+q      : 为标签增加类修饰符；
"                          注意，如果没有此选项，将不能对类成员补全.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按下F3自动补全代码，注意该映射语句后不能有其他字符，包括tab,否则会补全乱码.
imap <F3> <C-X><C-O>
" 按下F2根据头文件内关键字补全
imap <F2> <C-X><C-I>
set completeopt=menu,menuone           " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1         " autocomplete with .
let OmniCpp_MayCompleteArrow = 1       " autocomplete with ->
let OmniCpp_MayCompleteScope = 1       " autocomplete with ::
let OmniCpp_SelectFirstItem = 2        " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2        " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1    " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1        " enable the global scope search
let OmniCpp_DisplayMode=1              " Class scope completion mode: always show all members
" let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_ShowScopeInAbbr=1          " show scope in abbreviation and remove the last column
let OmniCpp_ShowAccess=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags database path设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按下F5重新生成tag文件，并更新taglist
map <F1> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F1> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>

" ctags DB位置,可修改为自己的路径
set tags=tags
set tags+=./tags           " add current directory's generated tags file.


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope database path设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
set csprg=/usr/bin/cscope                   " cscope设置
set csto=0                                  " cscope DB search first
set cst                                     " cscope DB tag DB search
set cscopequickfix=s-,c-,d-,i-,t-,e-        " 使用QuickFix窗口显示cscope查找结果

set nocsverb                                " verbose off
" cscope DB位置设置，<home/code>变更,使用绝对路径,若当前目录下存在cscope数据库,
" 添加该数据库到vim, 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
if filereadable("cscope.out")
	cs add cscope.out
elseif $CSCOPE_DB != "" 
	cs add $CSCOPE_DB
else
	cs add /home/takeno/projects/linux/iTop4412_Kernel_3.0/cscope.out /home/takeno/projects/linux/iTop4412_Kernel_3.0
endif
set csverb                                  " verbose off
endif

map <F4> :cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
imap <F4> <ESC>:cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
" 将:cs find c等Cscope查找命令映射为<C-_>c等快捷键（按法是先按Ctrl+Shift+-,
" 然后很快再按下c）
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR> :copen<CR><CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag List环境设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on                                 " vim filetype on
" F7 Key = Tag List Toggling
nmap <F7> :TlistToggle<CR>
let g:Tlist_Ctags_Cmd = "/usr/bin/ctags"      " ctags程序位置
let g:Tlist_Inc_Winwidth = 0                  " window width change off
let g:Tlist_Exit_OnlyWindow = 0               " tag/file完成选择时taglist 
                                            " window close = off
let g:Tlist_Auto_Open = 0                     " vim开始时window open = off
let g:Tlist_Use_Right_Window = 1              " vim开始时window open = off
let g:Tlist_Show_One_File = 0                 " 可以同时展示多个文件的函数列表
let g:Tlist_File_Fold_Auto_Close = 1          " 非当前文件，函数列表折叠隐藏
let g:Tlist_Process_File_Always = 1           " 实时更新tags
let g:Tlist_Auto_Highlight_Tag=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source Explorer环境设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F8 Key = SrcExpl Toggling
nmap <F8> :SrcExplToggle<CR>
" 向左侧窗口移动
nnoremap <C-H> <C-W>h
" 向下端(preview)窗口移动
nnoremap <C-J> <C-W>j
" 向上端窗口移动
nnoremap <C-K> <C-W>k
" 向右侧窗口移动
nnoremap <C-L> <C-W>l
inoremap <C-h> <Esc><C-W>h
inoremap <C-j> <Esc><C-W>j
inoremap <C-k> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l

let g:SrcExpl_winHeight = 8                 " 指定SrcExpl Windows高度
let g:SrcExpl_refreshTime = 100             " refreshing time = 100ms
let g:SrcExpl_jumpKey = "<ENTER>"           " 跳转(jump)至相应定义definition
let g:SrcExpl_gobackKey = "<SPACE>"         " back
let g:SrcExpl_isUpdateTags = 0              " tag file update = off


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD Tree环境设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"                 " NERD Tree位置=左侧
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=1
" F9 Key = NERD Tree Toggling
nmap <F2> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" winmanager
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = 'FileExplorer|TagList'   " 设置我们要管理的插件
" let g:persistentBehaviour=0                " 如果所有编辑文件都关闭了，退出vim
nmap wm :WMToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" minibufexplorer
" 用于浏览和管理buffer，如果只打开一个文件，是不会显示在屏幕上的，
" 而打开多个文件之后，会自动出现在屏幕
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1         " 按下Ctrl+h/j/k/l,
                                               " 可以切换到当前窗口的上下左右窗口
let g:miniBufExplMapWindowNavArrows = 1      " 按下Ctrl+箭头,
                                               " 可以切换到当前窗口的上下左右窗口
" 启用以下两个功能：Ctrl+tab移到下一个buffer并在当前窗口打开；
" Ctrl+Shift+tab移到上一个buffer并在当前窗口打开；ubuntu好像不支持
let g:miniBufExplMapCTabSwitchBufs = 1
" 启用以下两个功能：Ctrl+tab移到下一个窗口；
" Ctrl+Shift+tab移到上一个窗口；ubuntu好像不支持
" let g:miniBufExplMapCTabSwitchWindows = 1
" 不要在不可编辑内容的窗口（如TagList窗口）中打开选中的buffer
let g:miniBufExplModSelTarget = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码折叠fold
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldmethod=syntax                        " 用语法高亮来定义折叠
set foldlevel=100                            " 启动vim时不要自动折叠代码
set foldcolumn=1                             " 设置折叠栏宽度


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix命令集设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按下F6，执行make clean
map <F6> :make clean<CR><CR><CR>
" 按下F7，执行make编译程序，并打开quickfix窗口，显示编译信息
map <F10> :make<CR><CR><CR> :copen<CR><CR>
" 按下F8，光标移到上一个错误所在的行
map <F11> :cp<CR>
" 按下F9，光标移到下一个错误所在的行
map <F12> :cn<CR>
" 以上的映射是使上面的快捷键在插入模式下也能用
imap <F6> <ESC>:make clean<CR><CR><CR>
imap <F10> <ESC>:make<CR><CR><CR> :copen<CR><CR>
imap <F11> <ESC>:cp<CR>
imap <F12> <ESC>:cn<CR>

" "cd" to change to open directory.
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim GDB配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gdb")
    set asm=0
    let g:vimgdb_debug_file=""
    run macros/gdb_mappings.vim
endif

" LookupFile setting
let g:LookupFile_TagExpr='"./tags.filename"'
let g:LookupFile_MinPatLength=2
let g:LookupFile_PreserveLastPattern=0
let g:LookupFile_PreservePatternHistory=1
let g:LookupFile_AlwaysAcceptFirst=1
let g:LookupFile_AllowNewFiles=0

" snipMate
let g:snips_author="takeno2020"
let g:snips_email="takeno2020@163.com"
let g:snips_copyright="hades phantom"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
" vnoremap <silent> gv :call VisualSearch('gv')<CR>
" map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
"
"
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "","")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
