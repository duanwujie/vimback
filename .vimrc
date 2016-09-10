" for vim
"set nocompatible


syntax enable
filetype plugin indent on
set nowrap
set foldmethod=marker

" tab��Ĭ��4�ո�
set ts=4
set expandtab
set autoindent

set backspace=indent,eol,start

" for search
set hlsearch
set incsearch



autocmd Filetype [ch],cpp setlocal tags+=/usr/include/tags
autocmd FileType [ch],cpp setlocal cscopetag
autocmd FileType [ch],cpp setlocal cinoptions=g0,:0,N-s
" 

" for make 
autocmd FileType [ch],cpp,vim setlocal autowriteall
if filereadable("Makefile") || filereadable("makefile")
	set makeprg=make
else
	autocmd FileType [ch],cpp set makeprg=g++\ -Wall\ -o\ %<.out\ %
endif

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" 

" for GUI 
if has("gui")
	colorscheme evening
	set guioptions=
endif

" for mouse
if has('mouse')
	set mouse=c
endif

" 

" for plugin 

" plugin list
" a.vim
" taglist
" DoxygenToolkit.vim

" taglist
" let Tlist_Exit_OnlyWindow = 1
set mouse=a                            "��������Ǳ���ģ��������ܵ����ǩ
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Use_Left_Window=1 
let Tlist_Use_SingleClick=1             "���õ���һ��tag����ת�����壬Ĭ��Ϊ˫��
let Tlist_Auto_Open = 1                "���ÿ���vim�Զ���Tlist
" clang_complete
let g:clang_close_preview = 1 " the preview window will be close automatically after a completion.
let g:clang_complete_auto = 0 " non-automatically complete after ->, ., :: 

" for key map
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>  
map <silent> <F2> :TlistOpen<CR>  

" Set the cursor's mode


let tlist_mql4_settings = 'c;f:Functions'


" ���˸��ʱ�жϵ�ǰ���ǰһ���ַ�������������ţ���ɾ����Ӧ���������Լ������м������
function! RemovePairs()
	let l:line = getline(".")
	let l:previous_char = l:line[col(".")-1] " ȡ�õ�ǰ���ǰһ���ַ�
 
	if index(["(", "[", "{"], l:previous_char) != -1
		let l:original_pos = getpos(".")
		execute "normal %"
		let l:new_pos = getpos(".")
 
		" ���û��ƥ���������
		if l:original_pos == l:new_pos
			execute "normal! a\<BS>"
			return
		end
 
		let l:line2 = getline(".")
		if len(l:line2) == col(".")
			" ����������ǵ�ǰ�����һ���ַ�
			execute "normal! v%xa"
		else
			" ��������Ų��ǵ�ǰ�����һ���ַ�
			execute "normal! v%xi"
		end
 
	else
		execute "normal! a\<BS>"
	end
endfunction
" ���˸��ɾ��һ��������ʱͬʱɾ����Ӧ��������
inoremap <BS> <ESC>:call RemovePairs()<CR>a
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
"inoremap { {}<LEFT>
set tabstop=4
inoremap { {<ENTER><TAB><ENTER>}<UP><ESC>$i
