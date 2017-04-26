set et "编辑时将所有tab替换为空格
set smartindent "C自动缩进

"set wrap就可以造成屏幕折行，可是却会把一个英文单字折成两半，实在很不雅观。lbr就会避免这种问题发生，会在空白或标点符号的地方来折行，但也仍属屏幕折行，并不会插入 EOL。
set lbr
set fo+=mB

set sm
set selection=inclusive
set wildmenu
set mousemodel=popup

au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType c setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType scale setlocal dict+=~/.vim/dict/scale.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict

"syntastic相关
execute pathogen#infect()
let g:syntastic_python_checkers=['pylint']
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']

"golang
"Processing... % (ctrl+c to stop)
let g:fencview_autodetect=0
set rtp+=$GOROOT/misc/vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
syntax enable
"set cul "高亮光标所在行
"set cuc
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
set go=             " 不要图形按钮
"color desert     " 设置背景主题
"color torte     " 设置背景主题
color koehler2

 "autocmd InsertLeave * se nocul  " 用浅色高亮当前行
 autocmd InsertEnter * se cul    " 用浅色高亮当前行
set ruler           " 显示标尺
set showcmd         " 输入的命令显示出来，看的清楚些
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
"set foldenable      " 允许折叠
""set foldmethod=manual   " 手动折叠
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
    set completeopt=menu,longest,preview  "自动补全Ctrl+p时的一些选项：多于一项时显示菜单，最长选择，显示当前选择的额外信息
endif
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 使用空格代替制表符
set expandtab
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
" 历史记录数
set history=1000
"搜索逐字符高亮
set hlsearch
set incsearch
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
filetype plugin indent on
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"共享剪贴板
"set clipboard+=unnamed
"自动保存
set autowrite
"set cursorline              " 突出显示当前行 有下划线
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
""set foldcolumn=0
""set foldmethod=indent
""set foldlevel=3
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set nobackup
set noswapfile
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
"垂直缩进对期限
let g:indentLine_char=' '



""""""""""""""""""""""""""""
"markdown配置
""""""""""""""""""""""""""""
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript
"markdown to HTML
nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
nmap fi :!firefox %.html & <CR><CR>
nmap \ \cc
vmap \ \cc

"将tab替换为空格
nmap tt :%s/\t/    /g<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\#!/bin/bash")
		call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "")

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
	    call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else
		call setline(1, "/*************************************************************************")
		call append(line("."), "	> File Name: ".expand("%"))
		call append(line(".")+1, "	> Author: ")
		call append(line(".")+2, "	> Mail: ")
		call append(line(".")+3, "	> Created Time: ".strftime("%c"))
		call append(line(".")+4, " ************************************************************************/")
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
	"新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shift tab pages
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
map! <C-Z> <Esc>zzi
map! <C-O> <C-Y>,
map <C-A> ggVG$"+y
map <F12> gg=G
map <C-w> <C-w>w
imap <C-k> <C-y>,
imap <C-t> <C-q><TAB>
"imap <C-j> <ESC>
" 选中状态下 Ctrl+c 复制
"map <C-v> "*pa
imap <C-v> <Esc>"*pa
imap <C-a> <Esc>^
imap <C-e> <Esc>$
vmap <C-c> "+y
set mouse=v
"set clipboard=unnamed

""""""""""""""""""""""""""""
"去空行
""""""""""""""""""""""""""""
"nnoremap <F2> :g/^\s*$/d<CR>


""""""""""""""""""""""""""""
"比较文件
""""""""""""""""""""""""""""
nnoremap <C-F2> :vert diffsplit
"nnoremap <Leader>fu :CtrlPFunky<Cr>
"nnoremap <C-n> :CtrlPFunky<Cr>


""""""""""""""""""""""""""""
"C，C++ 按F5编译运行
""""""""""""""""""""""""""""
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc


""""""""""""""""""""""""""""
"C,C++的调试
""""""""""""""""""""""""""""
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc


""""""""""""""""""""""""""""
"代码格式优化化
""""""""""""""""""""""""""""
map <F6> :call FormartSrc()<CR><CR>
"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif




""""""""""""""""""""""""""""
"Tag list (ctags)
"""""""""""""""""""""""""""""
""let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树
let Tlist_Sort_Type = "name"    " 按照名称排序
let Tlist_Compart_Format = 1    " 压缩方式
let Tlist_Ctags_Cmd='/usr/bin/ctags'  "设定ctags程序路径
let Tlist_Show_One_File=1             "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow=1           "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window=1          "在右侧窗口显示taglist窗口
let Tlist_Use_SingleClick=1         "单击tag就跳转
"let Tlist_Close_On_Select=1         "选择tag后自动关闭taglist
"let Tlist_File_Fold_Auto_Close=1 "多文件时只显示当前文件的tag，其它的tag折叠
let Tlist_WinHeight=200       "taglist窗口高度
let Tlist_WinWidth=20        "taglist窗口宽度
"let Tlist_Use_Horiz_Window=1   "设置taglist窗口横向显示
""let Tlist_Auto_Open=1
"映射F8打开关闭taglist窗口
map <expr> <F9> bufloaded("__Tag_List__")?"q":":TlistOpen\<cr>"
"nmap <silent> <F9> <ESC>:Tlist<RETURN>
"设置tags
set tags=tags;
set autochdir


" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
nmap tl :Tlist<cr>

"python补全
let g:pydiction_location = '~/.vim/after/complete-dict'
let g:pydiction_menu_height = 20
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1


set iskeyword+=.
set termencoding=utf-8

autocmd FileType python set omnifunc=pythoncomplete#Complete


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'Yggdroot/indentLine'
"ndle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'https://github.com/wincent/command-t.git'
Bundle 'Auto-Pairs'
Bundle 'python-imports.vim'
Bundle 'CaptureClipboard'
Bundle 'ctrlp-modified.vim'
Bundle 'last_edit_marker.vim'
Bundle 'synmark.vim'
"Bundle 'Python-mode-klen'
Bundle 'SQLComplete.vim'
Bundle 'Javascript-OmniCompletion-with-YUI-and-j'
"Bundle 'JavaScript-Indent'
"Bundle 'Better-Javascript-Indentation'
Bundle 'jslint.vim'
Bundle "pangloss/vim-javascript"
Bundle 'Vim-Script-Updater'
Bundle 'ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'jsbeautify'
Bundle 'The-NERD-Commenter'
"django
Bundle 'django_templates.vim'
Bundle 'Django-Projects'

"Bundle 'FredKSchott/CoVim'
"Bundle 'djangojump'
" ...
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


""""""""""""""""""""""""""""
"ctrlp设置
""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']


""""""""""""""""""""""""""""
"Grep
"""""""""""""""""""""""""""""
nnoremap <silent> <F3> :Rgrep<CR>


""""""""""""""""""""""""""""
"MRU
"""""""""""""""""""""""""""""
"let MRU_File='/root/.vim/config/_vim_mru_files'  "把记录保存在哪
""let MRU_Max_Entries=10                          "最多保存多少条记录
"let MRU_Window_Height=8                         "设置MRU窗口高度
""let MRU_Use_Current_Window=0                     "设置是否让MRU窗口独点一页
"映射F2打开和关闭MRU窗口，bufloaded是判断缓冲是否加载
map <expr> <F2> bufloaded("__MRU_Files__")?"q":":MRU\<cr>"



""""""""""""""""""""""""""""
"NERDTree
""""""""""""""""""""""""""""
"let NERDChristmasTree=1            "让Tree把自己给装饰得多姿多彩些
"let NERDTreeAutoCenter=1 "控制光标移动超过一定距离时，是否自动将焦点y调整到屏中心
"let NERDTreeAutoCenterThreshold=1  "与上面配合使用
"let NERDTreeCaseSensitiveSort=1    "排序时是否大小写敏感
"let NERDTreeHighlightCursorline=1  "是否高亮显示光标所在行
"let NERDTreeBookmarksFile='/root/vim/bookmark.txt'  "指写书签文件
let NERDTreeMouseMode=2 "指定鼠标模式：1为双击打开，3为单击打开，2为目录为单击打开，文件双击打开
"let NERDTreeQuitOnOpen=1 "打开文件后是否关闭NerdTree窗口
let NERDTreeShowBookmarks=1        "是否默认显示书签列表
let NERDTreeShowFiles=1            "是否默认显示文件
let NERDTreeShowHidden=1           "是否默认显示隐藏文件
"let NERDTreeShowLineNumbers=1      "是否默认显示行号
"let NERDTreeSortOrder= "排序规则，这个就麻烦了，可以用正则表达式
"let NERDTreeStatusline=             "窗口状态栏
"let NERDTreeWinPos='right'          "窗口位置（left or right）
"let NERDTreeWinSize=20             "窗口宽
 let NERDTreeDirArrows=0 "垂直对齐符号，目录 1 显示箭头  0传统+-|号 如果不设置 就是方框
"映射F7打开关闭NERDTree窗口
"winnr()    获取当前窗口窗口ID
"winbufnr(winnr())   获取当前窗口的缓冲区ID
"bufname(winbufnr(winnr()))  获取当前窗口缓冲区的名字
"strpart(bufname(winbufnr(winnr())), 10) 截取从缓冲区名字第10字符开始到结束
map <expr> <F7> bufloaded("NERD_tree_".strpart(bufname(winbufnr(winnr())),10))?"q":":NERDTree\<cr>"
"列出当前目录文件
"map <F3> :NERDTreeToggle<CR>
"imap <F3> <ESC> :NERDTreeToggle<CR>
"打开树状文件目录
"map <C-F3> \be
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.pyc']



"设置命令行和状态栏
set cmdheight=1                 "设定命令行的行数为1
set laststatus=2                "显示状态栏(默认值为1，无法显示状态栏)
""windows:  set statusline=%F%m%r,%Y,%{&fileformat}\\\ASCII=\%b,HEX=\%B\\\ %l,%c%V\ %p%%\\\[\%L\ lines\ in\ all\]
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容
set statusline=%F%m%r\ ASCII=\%b,HEX=\%B,%l,%c%V\ %L-%p%%
"设置在状态行显示的信息如下：
"   %F              当前文件名
"   %m              当前文件修改状态
"   %r              当前文件是否只读
"   %Y              当前文件类型
"   %{&fileformat}  当前文件编码
"   %b              当前光标处字符的ASCII码值
"   %B              当前光标处字符的十六进制值
"   %l              当前光标行号
"   %c              当前光标列号
"   %V              当前光标虚拟列号(根据字符所占字节数计算)
"   %p              当前行占总行数的百分比
"   %%              百分号
"   %L              当前文件总行数
"


""""""""""""""""""""""""""""
"语言环境
""""""""""""""""""""""""""""
set encoding=utf-8
langua message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,gb2312
"设置字符编码列表
"set guifontwide=微软雅黑:h14 "设置中文的字体
set guifont=Bitstream_Vera_Sans_Mono:h14:cANSI:b  "设置英文的字体 :b加粗 :i斜体


""""""""""""""""""""""""""""
"Omincppcomplete
"""""""""""""""""""""""""""""
"下面的设置用于当用户预先声明namespace时也能自动补全代码（如使用using ""std::string）
let OmniCpp_DefaultNamespaces = ["std"]


""""""""""""""""""""""""""""
"映射,F4执行ctags命令
""""""""""""""""""""""""""""
map <F4> :!/usr/local/bin/ctags -f /webser/winwww/tags -R --languages=php*<cr>


""""""""""""""""""""""""""""
"SearchComplete
"""""""""""""""""""""""""""""

"获取当前文件名
function GetFileName()
    return bufname(winbufnr(winnr()))  "获取当前窗口缓冲区的名字
endfunction

"获取当前时间，精确到分
function GetDateTime()
    return strftime("%Y-%m-%d %H:%M")
endfunction


"自动补全（,",{,［
nnoremap <silent> ( i()<ESC>i
inoremap <silent> ( ()<ESC>i
nnoremap <silent> { i{}<ESC>i
inoremap <silent> { {}<ESC>i
nnoremap <silent> [ i[]<ESC>i
inoremap <silent> [ []<ESC>i
set pastetoggle=<F>

" 为C程序提供自动缩进
"自动补全
"":inoremap ( ()<ESC>i
"":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
"":inoremap [ []<ESC>i
"":inoremap ] <c-r>=ClosePair(']')<CR>
"":inoremap " ""<ESC>i
"":inoremap ' ''<ESC>i
""function! ClosePair(char)
""	if getline('.')[col('.') - 1] == a:char
""		return "\<Right>"
""	else
""		return a:char
""	endif
""endfunction


"添加文件说明信息
nnoremap <silent> <C-S-2> ggi/*<CR>
            \*******************************************************************************
            \<CR>*<CR>*   FileName    :    <C-R>=GetFileName()<ESC>
            \<CR>*<CR>*   Author      :    kyo <kyo2018@gmail.com>
            \<CR>*<CR>*   Created     :    <C-R>=GetDateTime()<ESC>
            \<CR>*<CR>*   Description :
            \<CR>*<CR>
            \*******************************************************************************
            \<CR>*/<CR><CR>

inoremap <silent> <C-S-1> <ESC>ggi/*<CR>
            \*******************************************************************************
            \<CR>*<CR>* FileName : <C-R>=GetFileName()<ESC>
            \<CR>*<CR>* Author : kyo <kyo2018@gmail.com>
            \<CR>*<CR>* Created : <C-R>=GetDateTime()<ESC>
            \<CR>*<CR>* Description :
            \<CR>*<CR>
            \*******************************************************************************
            \<CR>*/<CR><CR>


"添加函数说明信息
nnoremap <silent> <F11> i<CR>/*<CR>
\*******************************************************************************
\<CR>*<CR>* Function    :
\<CR>*<CR>* Input       :
\<CR>*<CR>* Output      :
\<CR>*<CR>* Return      :
\<CR>*<CR>* Description :
\<CR>*<CR>* Author      :    <C-R>=GetDateTime()<ESC>   by   kyo <kyo2018@gmail.com>
\<CR>*<CR>
\*******************************************************************************
\<CR>*/<CR><CR>

inoremap <silent> <F4> <CR>/*<CR>
            \*******************************************************************************
            \<CR>*<CR>* Function :
            \<CR>*<CR>* Input :
            \<CR>*<CR>* Output :
            \<CR>*<CR>* Return :
            \<CR>*<CR>* Description :
            \<CR>*<CR>* Author : <C-R>=GetDateTime()<ESC>   by   yuyangyang <yuyangyang4807@gmail.com>
            \<CR>*<CR>
            \*******************************************************************************
            \<CR>*/<CR><CR>



"添加自定义代码块注释，以区别是自己添加的代码
nnoremap <silent> <C-F5> O
            \/* kyo Start <C-R>=GetDateTime()<ESC> */<ESC>o
            \/* kyo End <C-R>=GetDateTime()<ESC> */<ESC>O
inoremap <silent> <C-F5> <ESC>O
            \/* kyo Start <C-R>=GetDateTime()<ESC> */<ESC>o
            \/* kyo End <C-R>=GetDateTime()<ESC> */<ESC>O

vnoremap <silent> <F5> dO
            \#if 0 //kyo Comment Start <C-R>=GetDateTime()<ESC><ESC>o
            \#endif //kyo Comment End <C-R>=GetDateTime()<ESC><ESC>O<CR><ESC>p

nnoremap <silent> <F5> O
            \#if 0 //kyo Comment Start <C-R>=GetDateTime()<ESC><ESC>o
            \#endif //kyo Comment End <C-R>=GetDateTime()<ESC><ESC>O

inoremap <silent> <F5> <ESC>O
            \#if 0 //kyo Comment Start <C-R>=GetDateTime()<ESC><ESC>o
            \#endif //kyo Comment End <C-R>=GetDateTime()<ESC><ESC>O                                           "

"屏幕切换
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

""恢复文件关闭之前光标位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

nnoremap ,ms  i#include <stdio.h><CR>#include <string.h><CR>
            \#include <stdlib.h><CR>#include <sys/types.h><CR>#include <sys/stat.h><CR>
            \#include <errno.h><CR>#include <fcntl.h><CR>#include <unistd.h><CR><CR>
            \int main(void)<CR>{<CR>return 0;<ESC>v=o}<ESC>=kO


set tags+=~/.vim/systags

vnoremap "y  :w! /tmp/kyo.vim<CR><CR>
vnoremap "p  :r /tmp/kyo.vim<CR><CR>
nnoremap "p  :r /tmp/kyo.vim<CR><CR>

nnoremap ,ma i#include <stdio.h><CR><CR>int main(void)<CR>{<CR>return 0;<ESC>v=o}<ESC>v=kO

set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
set tags+=/webser/winwww/tags
