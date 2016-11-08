"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" .vimrc file of Alex Quinn
" License:  public domain (use as you please, no credit needed)
"
" vim: set tabstop=4 shiftwidth=4 fileencoding=utf8 expandtab:

set nocompatible " Use VIM settings rather than Vi settings; this *must* be
                 " first in .vimrc

"_________________________________________________________________________
" COLORS
"

if !has("gui_running")
    " In non-GUI mode (vim), use the "evening"
    colorscheme evening
else
    " In GUI mode (gvim), use the "leo" color scheme or "default" as a fallback
    try
        colorscheme leo " might not be on every system
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default " should be on every system
    endtry
endif

" SYNTAX HIGHLIGHTING... on if terminal has colors
if &t_Co > 2 || has("gui_running")
    syntax on
endif


"_________________________________________________________________________
" WINDOWS-SPECIFIC
"

" load some scripts that are packaged with the Windows version of Vim.
let s:is_windows = (has("win32") || has("win64"))
if s:is_windows
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    if has("gui_running")
        set guifont=DejaVu_Sans_Mono:h11,Inconsolata:h11,Consolas:h11,Fixedsys:h9
    endif
endif


"_________________________________________________________________________
" GENERAL SETTINGS
"

set autoindent          " copy indent from the current line when starting a new line
set backspace=2         " allow backspacing over everything in insert mode
set history=50          " keep 50 lines of command line history
set ignorecase          " search commands are case-insensitive
set incsearch           " while typing a search command, show matches incrementally
                        " instead of waiting for you to press enter
set mouse=a             " enable mouse interaction
set number              " line numbers at the side
set ruler               " show the cursor position all the time
set shiftwidth=4        " pressing >> or << in normal mode indents by 4 characters
set tabstop=4           " a tab character indents to the 4th (or 8th, 12th, etc.) column
set viminfo='20,\"50    " read/write a .viminfo file, don't store more than 50 lines of registers
set encoding=utf8       " non-ascii characters are encoded with UTF-8 by default
set noexpandtab         " pressing the tab key creates a tab character, not spaces
set formatoptions=croq  " c=autowrap comments, r=continue comment on <enter>,
                        " o=continue comment on o or O, q=allow format comment with gqgq
set textwidth=0         " no forced wrapping in any file type (unless overridden)
set showcmd             " show length of visual selection (docs recommended
                        " keeping this off when working over slow connections)
set complete=.,w,b,u    " make autocomplete faster - http://www.mail-archive.com/vim@vim.org/msg03963.html
set splitright          " create vertical splits to the right
set splitbelow          " create horizontal splits below

if exists(":tabedit")   " if this version of vim supports tabs...
    set switchbuf=usetab " when switching buffers, include tabs
    set tabpagemax=30   " show up to 30 tabs
endif

if version >= 703       " if version 7.3+ of Vim...
    set cryptmethod=blowfish " use blowfish encryption for encrytped files
endif

" Enable backup files - Every time you save a file, it will create a copy of the file
" called <filename>~ (e.g., file.txt~) in the directory ~/.vim/backup_files/.
"
" Run `mkdir ~/.vim/backup_files`, uncomment the following lines, and delete this line.
"
" set backup
" let &backupdir=($HOME . '/.vim/backup_files')



"_________________________________________________________________________
" GUI OPTIONS - only affects gvim
"
if has("gui_running")
    set hlsearch                " Highlight last used search pattern
    au GUIEnter * simalt ~x     " Start maximized
    set guioptions-=T           " No toolbar
    set guioptions-=m           " No menus
    set guioptions-=L           " No left scrollbar
    set guioptions-=r           " No right scrollbar
endif


"_________________________________________________________________________
" MAPPINGS for normal mode
"

" F1 - help on some command
map <F1> :h 

" F2 - open file in new tab
map <F2> :tabe 

" F3 - save current file
map <F3> :w<CR>

" F4 - exit
map <F4> :q<CR>

" Shift-F4 - exit without saving
map <S-F4> :q!<CR>

" F6 - switch to next split
map <F6> <C-W><C-W>

" Shift-F6 - switch to next split, in reverse order
map <S-F6> <C-W>W

" F7 - Start search command, delimited by comma
nmap <F7> :%s,

" F8 - stop highlighting search results
map <F8> :noh<CR>

" F9 - change a setting
map <F9> :set 

" Shift-F9 - change a setting, only in current tab/buffer
map <S-F9> :setlocal 

" F12 - toggle display of whitespace
nmap <F12> :let &list=!&list \| set list?<CR>

" ; (semicolon) - same as : (colon)
nmap ; :

" ' ' (space) - same as : (colon)
nmap <SPACE> :

" [ (left bracket) - change tabs to the left
nnoremap [ gT

" [ (right bracket) - change tabs to the right
nnoremap ] gt


"_________________________________________________________________________
" MAPPINGS for insert mode
"

" F2 - add another item to a comma-separated list of strings
imap <F2> <RIGHT>, ""<LEFT>

" F3 - autocomplete, backward
inoremap <F3> <C-P>

" F4 - autocomplete, forward
inoremap <F4> <C-N>

" F5 - underscore (to save pinky finger)
map! <F5> _

" F6 - pair of curly braces, continue typing inside them
map! <F6> {}<LEFT>

" F7 - pair of parentheses, continue typing after them
map! <F7> ()

" F8 - pair of parentheses, continue typing inside them
map! <F8> ()<LEFT>

" F9 - pair of parentheses with extra spaces inside, continue typing inside them
map! <F9> (  )<LEFT><LEFT>

" F10 - pair of double quotation marks, continue typing inside them
map! <F10> ""<LEFT>

" Shift-F10 - pair of single quotation marks, continue typing inside them
map! <S-F10> ''<LEFT>

" F11 - pair of square brackets, continue typing inside them
map! <F11> []<LEFT>

" F12 - pair of angle brackets, continue typing inside them
map! <F12> <><LEFT>


"_________________________________________________________________________
" ARCANE SETTINGS AND TWEAKS
"

" xml ftplugin:  Don't automatically create new nesting level for every element.
" http://www.vim.org/scripts/script.php?script_id=301
" https://github.com/sukima/xmledit/
let xml_no_auto_nesting = 1

" When listing directories, hide temporary files or binary files.  Allow
" gzip/bzip2 though, since Vim can sometimes open those.
let g:netrw_list_hide=join(['^.\+\.pyc$',
                           \'^.\+\.pyo$',
                           \'^.\+\.jpg$',
                           \'^.\+\.png$',
                           \'^.\+\.exe$',
                           \'^.\+\.class$',
                           \'^.\+\.zip$',
                           \'^.\+\.pyo$',
                           \'^.\+\.pyc$',
                           \'^.\+\.xls[xm]\=$',
                           \'^.\+\.doc[xm]\=$',
                           \'^.\+\.ppt[xm]\=$',
                           \'^.\+\.sqlite3\=$',
                           \'^.\+\.sqlite3\=$',
                           \'^\..\+\.sw.$'],
                           \',')
let g:netrw_hide=1         " Enable hiding based on g:netrw_list_hide
let g:netrw_mouse_maps=0   " Ignore mouse clicks

" Use old-fasioned HTML with the Tohtml command, so that it can be pasted into
" emails.
let g:html_use_css = 0

" Don't show line numbers when converting to HTML.
let g:html_number_lines=0

set diffexpr=MyDiff()
function! MyDiff()
  " Credit: source unknown (not written by Alex Quinn)
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
"
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
