:syntax on

" Neovim requires Python paths
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" allow shift + tab to deintend (like in other IDEs)
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
nnoremap <C-k> :ALEFix<CR>

" Shortcut to close xml tags
imap ,/ </<C-X><C-O><Esc>

" restore backspace behavior
set backspace=2

" show line numbers
set number

" highlight cursor
set cursorline

" configure tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" change search to be case-insensitive
set ignorecase
set smartcase

call plug#begin('~/.config/nvim/plugged')

" Theme
Plug 'iCyMind/NeoSolarized'

" Completion
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'https://github.com/slashmili/alchemist.vim'

" JS
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'mxw/vim-jsx'
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mustache/vim-mustache-handlebars'
" Plug 'ludovicchabant/vim-gutentags' " Since glutentags nvim is very laggy and slow
Plug 'kchmck/vim-coffee-script'

" Ruby
Plug 'tpope/vim-rvm'

" Nicer comments
Plug 'scrooloose/nerdcommenter'

" Syntax check
Plug 'w0rp/ale'

" Files
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Status Lines
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

" Git stuff
Plug 'tpope/vim-fugitive'

" Vue
Plug 'posva/vim-vue'

" Fuzzy Search
Plug 'ctrlpvim/ctrlp.vim'

" Autocompletion of { blocks
Plug 'jiangmiao/auto-pairs'

" Autocomplete begin end's
Plug 'danieljaouen/vim-endwise'

" Autosave
Plug 'vim-scripts/vim-auto-save'

" Powershell
Plug 'PProvost/vim-ps1'

" MS intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}


call plug#end()

" coc configuration

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions = ['coc-solargraph']


set termguicolors
if has('gui_vimr')
	set background=dark
	colorscheme NeoSolarized
        let g:airline_theme='solarized'
        
        " Use light theme during day, dark theme during night
        let hour = strftime("%H")
        if 6 <= hour && hour < 18
          set background=light
          let g:airline_solarized_bg='light'
        else
          set background=dark
          let g:airline_solarized_bg='dark'
        endif

	"set guifont=Menlo\ for\ Powerline
        "set Guifont=Fira_Code
	"set macligatures

        " Fix writing umlauts with alt+u
        " defaults write org.vim.MacVim MMUseInlineIm 0
endif


""" TODO: make this work! x and v are already used
"" adjust split shortcuts to be the same in every plugin
" let NERDTreeMapOpenSplit = 'x'
" let NERDTreeMapOpenVSplit = 'v'
" let NERDTreeMapCloseChildren = ''
" let NERDTreeMapCloseDir = ''
" CtrlP uses CTRL+x for horizontal split and CTRL+v for vertical split

" open nerdtree if vim started without file arg
if !argc() 
  let g:ctrlp_working_path_mode = 'a'
  au vimenter * NERDTree

  let g:auto_save = 1
  let g:auto_save_in_insert_mode = 0
  autocmd BufEnter * Rvm
endif

"" Deoplete Stuff
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = [" — persistent"]

"" Config for ALE
let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'json': ['prettier'],
\  'css': ['prettier'],
\  'vue': ['eslint'],
\  'ruby': ['rubocop']
\}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {
      \ 'vue': ['eslint', 'vls'],
      \ 'ruby': ['rubocop', 'ruby']
      \}


filetype plugin on
filetype detect

"" Workaround for randomly syntax highlighting problems in .vue files"
autocmd FileType vue syntax sync fromstart


"" Use deoplete. Use deoplete
let g:deoplete#enable_at_startup = 1

"" Use neosnippet
let g:neosnippet#enable_completed_snippet = 1

" Fuzzy Search: Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Use tabs instead of spaces in makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
