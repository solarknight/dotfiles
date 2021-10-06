" No compatible mode
set nocompatible

" Auto called by vim-plug now
filetype plugin indent on

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Plugins list

"" Look and Feel
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'kshenoy/vim-signature'

"" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"" Text
Plug 'wellle/targets.vim'
Plug 'coderifous/textobj-word-column.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'

"" File Explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

"" Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

"" Terminal
Plug 'voldikss/vim-floaterm'

"" Programming
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Initialize plugin system
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim compatible
if !has('nvim')
    set ttymouse=xterm2
endif

" Nvim specific configuration items
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax
syntax enable

" Enable true color
if exists('+termguicolors')
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Specify background
set background=dark

" => Colorscheme
try 
    let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set extra options when running in GUI mode
if has("gui_running")
    " Remove widgets
    set guioptions-=M
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=e

    " Fullscreen
    set fu

    " Set font
    set guifont=Inconsolata-g:h14

    " No cursor blinking
    set guicursor+=a:blinkon0

    autocmd VimLeave * macaction terminate:
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Reduce vim updatetime
set updatetime=300

" Set to auto read when a file is changed from the outside
set autoread

" Encoding
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Backups
set nobackup
set nowb
set noswapfile

" Split below & right
set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show line number
set nu

" Highlight line under cursor
set cursorline

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs :)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" No fold
set nofoldenable

" No auto comment in new line
set formatoptions-=cort

" Always show the status line
set laststatus=2

" Hide standard prompt (for we have lightline plugin)
set noshowmode

" More powerful backspacing
set backspace=indent,eol,start

" Switch buffer with changes
set hidden

" Always show signcolumns
set signcolumn=yes

" No octal number
set nrformats-=octal

" Specify comment style
highlight Comment cterm=italic gui=italic

" Jsonc comment highlight
autocmd FileType json syntax match Comment +\/\/.\+$+

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight all search matches
set hlsearch

" Incremental search
set incsearch

" Show search count message when searching
set shortmess-=S
set shortmess+=c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Backward Match
noremap \ ,

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit
nmap <leader>q :q<cr>
nmap <leader>Q :q!<cr>

" Fast save and quit
nmap <leader>wq :wq<cr>

" Easy copy
map <leader>y "*y<cr>

" Easy paste
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Insert new line while stay in normal mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Easy Join
map <leader>j :-1s/$/,/<CR>:'<,'>j<CR>:noh<CR>
map <leader>J :0,$-1s/$/,/<CR>:%j<CR>:noh<CR>

" :W sudo saves the file 
" " (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" buffers
nnoremap <Leader>b :ls<CR>:b<Space>

" marks
nnoremap <Leader>m :marks<CR>

" Quick leave insert mode
inoremap jj <ESC>

" Turn off highlighting
nnoremap <silent> <C-l> :<C-u>noh<CR><C-l>

" Avoid wrong key
map <F1> <Esc>
imap <F1> <Esc>

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
" Use Alt + jkhl to move between windows for mac
map ∆ <C-W>j
map ˚ <C-W>k
map ˙ <C-W>h
map ¬ <C-W>l

" Close the current buffer
map <leader>bd :bd<CR>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify shell
set shell=zsh


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Preferences
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" matchit 
runtime macros/matchit.vim

" IndentLine
let g:indentLine_setColors = 0
" let g:indentLine_char = '▏'
let g:indentLine_char_list = ['¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['markdown']

" NERD Tree
" Change default window size
let g:NERDTreeWinSize=40

" Toggle like Intellij IDEA project window
function! ToggleNERDTreeBar()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        if bufname('%') !~ 'NERD_tree_.\+'
            silent NERDTreeFocus
        else
            silent NERDTreeToggle
        endif
    else
        silent NERDTreeFocus
    endif
endfunction

" Use <Alt-1> <Alt-2> toggle between windows
" Characters only work in MacOS
map <silent> ¡ :call ToggleNERDTreeBar()<CR>
map ™ <C-W>l

map <leader>nn :NERDTreeToggle<CR>
map <leader>nb :NERDTreeFromBookmark<CR>
map <leader>nf :NERDTreeFind<CR>

" Open a NERDTree automatically when vim starts up if no files were specified, but let vim-startify run first
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify | NERDTree | wincmd w | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | wincmd w | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#282828')
call NERDTreeHighlightFile('ini', 'yellow', 'none', '#afb42b', '#282828')
call NERDTreeHighlightFile('md', 'blue', 'none', '#0093c4', '#282828')
call NERDTreeHighlightFile('yml', 'green', 'none', '#E0E0E0', '#282828')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#282828')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#282828')
call NERDTreeHighlightFile('json', 'yellow', 'none', '#CE93D8', '#282828')
call NERDTreeHighlightFile('html', 'yellow', 'none', '#90CAF9', '#282828')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#282828')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#282828')
call NERDTreeHighlightFile('coffee', 'red', 'none', 'red', '#282828')
call NERDTreeHighlightFile('js', 'red', 'none', '#ffa500', '#282828')
call NERDTreeHighlightFile('php', 'cyan', 'none', '#B2DFDB', '#282828')
call NERDTreeHighlightFile('java', 'red', 'none', '#B2EBF2', '#282828')
call NERDTreeHighlightFile('sh', 'red', 'none', '#FF9E80', '#282828')

" lightline
let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'cocstatus': 'coc#status'
            \ },
            \ }

" fzf
map <C-p> :<C-u>FZF<CR>
map <C-b> :<C-u>Buffers<CR>
map <C-h> :<C-u>History:<CR>

let g:fzf_colors =
            \ { 'fg':    ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Statement'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'] }

" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-floaterm
let g:floaterm_keymap_toggle = '£'

" gitgutter
let g:gitgutter_max_signs = 2500

" EditorConfig Recommended Options
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" markdown
let g:mkdp_auto_start = 1

"" vista.vim
nmap ¢ :Vista!!<CR>
let g:vista_default_executive = 'ctags'
let g:vista#renderer#enable_icon = 1
let g:vista_close_on_jump = 1
let g:vista_close_on_fzf_select = 1


"" vim-go
" use coc lsp instead
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0

let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" highlight
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

autocmd BufEnter *.go nmap <leader>t  <Plug>(go-test)
autocmd BufEnter *.go nmap <leader>tf <Plug>(go-test-func)


"" CoC relative
" Quick edit config file
nmap <leader>C :CocConfig<CR>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
							  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
	call CocActionAsync('doHover')
  else
	execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
