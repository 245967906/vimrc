" brew install vim --with-lua --with-override-system-vi
" pip install yapf
" pip install flake8
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" vim +PlugInstall +qa


" General {{{
syntax enable
set nocompatible
set list
set listchars=tab:>-,trail:-
set hlsearch
set ignorecase
set incsearch
set expandtab
set shiftwidth=4
set tabstop=4
set backspace=indent,eol,start
set number
set numberwidth=5
set relativenumber
set mouse=v
set tags=~/.tags;
set autochdir
set foldmethod=indent
set foldlevel=99
set cursorline
nnoremap <space> za
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <F3> :tabp<CR>
nnoremap <F4> :tabn<CR>
nnoremap <F5> :call RunScripts()<CR>
function! RunScripts()
    exec 'w'
    if &filetype == 'python'
        exec '!time python %'
    elseif &filetype == 'sh'
        exec '!time bash %'
    elseif &filetype == 'html'
        exec '!open -a "Google Chrome" %'
    endif
endfunc
autocmd BufReadPost *
    \ if line("'\"") > 0 |
    \     if line("'\"") <= line("$") |
    \         exe("norm '\"") |
    \     else |
    \         exe "norm $" |
    \     endif |
    \ endif
autocmd FileType python match OverLength /\%80v.\+/
autocmd FileType html,css,javascript,vue,yaml set
    \ colorcolumn=79
    \ shiftwidth=2
    \ tabstop=2
autocmd FileType python set
    \ colorcolumn=79
    \ shiftwidth=4
    \ tabstop=4
autocmd FileType gitcommit set textwidth=72
" }}}


" junegunn/vim-plug {{{
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'davidhalter/jedi-vim'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'guns/xterm-color-table.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
call plug#end()
" }}}


" altercation/vim-colors-solarized {{{
set background=dark
set guifont=Monaco\16
set t_Co=256
let g:solarized_termcolors = 256
let g:solarized_termtrans  = 1
let g:solarized_degrade    = 0
let g:solarized_bold       = 0
let g:solarized_underline  = 0
let g:solarized_italic     = 0
let g:solarized_contrast   = "normal"
let g:solarized_visibility = "normal"
colorscheme solarized
highlight LineNr      ctermbg=NONE  ctermfg=240
highlight CursorLine  ctermbg=000   ctermfg=NONE
highlight Pmenu       ctermbg=235   ctermfg=252     cterm=NONE
highlight PmenuSel    ctermbg=232   ctermfg=031
highlight ColorColumn ctermbg=052   ctermfg=None
highlight OverLength  ctermbg=052   ctermfg=255
" }}}


" ctrlpvim/ctrlp.vim {{{
let g:ctrlp_mruf_max = 500
let g:ctrlp_max_history = 500
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|svn)$',
  \ 'file': '\v\.(swp|pyc)$'
  \ }
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip
noremap <leader><leader> :CtrlPMixed<cr>
noremap <leader><leader><leader> :CtrlPMRU<cr>
" }}}


" davidhalter/jedi-vim {{{
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 1
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#goto_command = "<C-]>"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "<leader>k"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-x><C-o>"
let g:jedi#rename_command = "<leader>r"
" }}}


" google/yapf {{{
autocmd FileType python map <C-Y> :YAPF<CR>
" }}}


" guns/xterm-color-table.vim {{{
" : XtermColorTable
" }}}


" kien/rainbow_parentheses.vim {{{
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
" }}}


" mattn/emmet-vim {{{
let g:user_emmet_mode='iv'
let g:user_emmet_leader_key = '<C-Y>'
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall
" }}}


" prettier/vim-prettier {{{
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_path = ""
let g:prettier#exec_cmd_async = 1

let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#prose_wrap = 'preserve'
let g:prettier#config#html_whitespace_sensitivity = 'css'

autocmd FileType html,css,javascript,vue map <C-Y> :Prettier<CR>
" }}}


" Raimondi/delimitMate {{{
" }}}


" scrooloose/nerdcommenter {{{
" }}}


" scrooloose/nerdtree {{{
map <F2> :NERDTreeToggle<CR>
let NERDTreeWinSize = 40
let NERDChristmasTree = 1
let NERDTreeChDirMode = 1
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
let NERDTreeIgnore = [
    \ '__pycache__',
    \ '\.git',
    \ '\~$',
    \ '\.pyc$',
    \ '\.swp$']
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}


" terryma/vim-multiple-cursors {{{
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<C-a>'
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-a>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
function! Multiple_cursors_before()
    let g:ycm_filetype_whitelist = {}
    let g:ycm_filetype_blacklist = { '*': 1 }
endfunction

function! Multiple_cursors_after()
    let g:ycm_filetype_whitelist = { '*': 1 }
    let g:ycm_filetype_blacklist = {}
endfunction
" }}}


" Valloric/YouCompleteMe {{{
let g:ycm_python_binary_path = ''
let g:ycm_global_ycm_extra_conf = ''
let g:ycm_cache_omnifunc = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_filetype_blacklist = {}
let g:ycm_semantic_triggers = {
    \   'python': ['re!(import\s+|from\s+(\S+\s+(import\s+(\w+,\s+)*)?)?)'],
    \   'css': ['re!(^\s{2,}|:\s+)'],
    \ }
" }}}


" vim-airline/vim-airline
" vim-airline/vim-airline-themes {{{
set t_Co=256
set noshowmode
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'
" }}}


" w0rp/ale {{{
let g:ale_linters = { 'python': ['flake8'] }
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✗'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
highlight SignColumn     ctermbg=NONE
highlight ALEErrorSign   ctermbg=None ctermfg=160
highlight ALEWarningSign ctermbg=None ctermfg=202
" }}}


" Yggdroot/indentLine {{{
let g:indentLine_char = '¦'
let g:indentLine_setColors = 1
let g:indentLine_color_term = 239
let g:indentLine_enabled = 1
autocmd BufRead,BufEnter,BufNewFile * IndentLinesReset
" }}}
