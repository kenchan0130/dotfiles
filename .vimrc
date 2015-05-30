let $VIM_ROOT=$HOME.'/.vim'
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand($VIM_ROOT.'/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'syui/airsave.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'einars/js-beautify'
NeoBundle 'jtratner/vim-flavored-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'elzr/vim-json'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'motemen/xslate-vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'szw/vim-tags'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'OrangeT/vim-csharp'
NeoBundle '5t111111/neat-json.vim'
NeoBundle 'Chiel92/vim-autoformat'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'basyura/unite-rails'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'StanAngeloff/php.vim.git'
NeoBundle 'rhysd/vim-operator-surround', {'depends': ['kana/vim-operator-user']}


" vim-operator-surround
" ------------------------------------
nmap <silent>sa <Plug>(operator-surround-append)
nmap <silent>sd <Plug>(operator-surround-delete)
nmap <silent>sr <Plug>(operator-surround-replace)

" vim-multiple-cursors
" ------------------------------------
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-x>'

" vim-alignta
" ------------------------------------
vnoremap <silent> => :Align @1 =><CR>
vnoremap <silent> == =

" vim-flavored-markdown
" ------------------------------------
autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown

" vim-autoformat
" See also: https://github.com/Chiel92/vim-autoformat
" ------------------------------------
noremap <silent> :af :<C-u>Autoformat<CR>

" nerdtree
" ------------------------------------
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden  = 1
nnoremap <silent> :nt :NERDTreeToggle<CR>
" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 無視するファイルを設定する
let g:NERDTreeIgnore = ['\.clean$', '\.swp$', '\.bak$', '\~$']
" 引数があれば非表示
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" マウスサポート
let g:NERDTreeMouseMode=3

" vim-json
" ------------------------------------
let g:vim_json_syntax_conceal = 0

" airsave
" ------------------------------------
let g:auto_write = 1

" unite
" ------------------------------------
nnoremap <silent> :uf :<C-u>Unite -buffer-name=files file file/new<CR>
nnoremap <silent> :ub :<C-u>Unite buffer<CR>
nnoremap <silent> :ua :<C-u>Unite -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> :us :<C-u>Unite snippet<CR>
nnoremap <silent> <Space>r :<C-u>QuickRun -outputter/buffer/split ":botright"<CR>

" neocomplcache setting
"----------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_min_keyword_length = 4
let g:neocomplcache_min_syntax_length  = 3
let g:neocomplcache_enable_ignore_case = 0
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_snippets_dir    = $VIM_ROOT.'/snippets'
let g:neosnippet#snippets_directory = $VIM_ROOT.'/snippets'
let g:neocomplcache_skip_auto_completion_time = '0.3'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default'    : '',
    \ 'perl'       : $VIM_ROOT.'/dict/perl.dict'
    \ }
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)


" syntastic setting
"----------------------------------------
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': ['ruby', 'perl'],
  \ 'passive_filetypes': ['html']
  \}
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl']
let g:syntastic_coffee_checkers = ['coffeelint', 'coffee']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exec = $HOME.'/.rbenv/shims/rubocop'

" neosnippet setting
"----------------------------------------
nnoremap <silent> :ns :NeoSnippetEdit<CR>

let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-i> <Plug>(neosnippet_expand_or_jump)
smap <C-i> <Plug>(neosnippet_expand_or_jump)
xmap <C-i> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
			\"\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
			\"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
	set conceallevel=2 concealcursor=i
endif


" emmet
" ------------------------------------
let g:user_emmet_expandabbr_key = '<C-e>'

let g:user_emmet_settings = {
			\'indentation' : '  ',
			\'lang' : 'ja'
			\}

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck



" Perl用設定
autocmd BufNewFile,BufRead *.psgi set filetype=perl
autocmd BufNewFile,BufRead *.t    set filetype=perl
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"


" Rails
autocmd BufEnter * if exists("b:rails_root") | NeoComplCacheSetFileType ruby.rails | endif
autocmd BufEnter * if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$") | NeoComplCacheSetFileType ruby.rspec | endif

" Ruby
autocmd BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.erb set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.thor set nowrap tabstop=2 shiftwidth=2 softtabstop=2 filetype=ruby
autocmd BufNewFile,BufRead *file set nowrap tabstop=2 shiftwidth=2 softtabstop=2 filetype=ruby
autocmd BufNewFile,BufRead Movefile set nowrap tabstop=2 shiftwidth=2 softtabstop=2 filetype=yaml

" YAML
autocmd BufNewFile,BufRead *.yml set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.yaml set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" CoffeeScript
autocmd BufNewFile,BufRead *.coffee set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" HTML
autocmd BufNewFile,BufRead *.html set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" SCSS/SASS
autocmd BufNewFile,BufRead *.scss set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.sass set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" PHP
autocmd BufNewFile,BufRead *.php set nowrap noexpandtab tabstop=2 shiftwidth=2 softtabstop=2


" マウス操作を許可
set mouse=a

" tagsの設定
set tags=.tags

" 行番号の表示
set nu

" 右下に表示される行・列の番号を表示
set ruler

" 自動インデントを有効にする
set autoindent

" タブをスペースにする
set expandtab

" タブを表示する時の幅
set tabstop=4

" 自動で挿入されるインデントの幅
set shiftwidth=4

" タブ入力時の幅
set softtabstop=4

" 閉じ括弧入力時に対応する括弧の強調
set showmatch

" showmatch設定の表示秒数(0.1秒単位)
set matchtime=4

" インクリメンタルサーチを行う(検索文字入力中から検索)
set incsearch

" 文字列検索で大文字小文字を区別しない
set ignorecase

" 文字列検索でマッチするものをハイライト表示する
set hlsearch

" 検索文字に大文字が含まれる場合にignorecaseをOFFにする(大文字小文字を区別する)
set smartcase

" コマンドラインにおける補完候補の表示
set wildmenu

" Deleteキーを有効にする
set t_kD=^?

" バックスペースキーの動作を普通のテキストエディタと同じようにする
set backspace=indent,eol,start

" 見た目によるカーソル移動をする(1行が複数行に渡って表示されている時に表示上の行ごとに上下移動させる)
nnoremap j gj
nnoremap k gk

" シンタックスを有効にする(コードをカラーを付けて見やすくする)
syntax enable

" カラー設定
colorscheme torte

" エンコーディングをutf8に設定
set encoding=utf8

" ファイルエンコードをutf8に設定
set fileencoding=utf8

" 編集中のファイル名を表示
set title

" ウィンドウの幅より長い行は折り返して表示
set wrap

" ステータスバーを常に表示
set laststatus=2

" アンダーラインを表示
set cursorline

" スクロールする時に下が見えるようにする
set scrolloff=5

" .swapファイルを作らない
set noswapfile

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k

" 行頭・行末移動方向をキーの相対位置にあわせる
nnoremap 0 $
nnoremap 1 0

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" カーソル前の文字削除
" inoremap <silent> <C-h> <C-g>u<C-h>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" カーソルから行頭まで削除
inoremap <silent> <C-d>e <Esc>lc^
" カーソルから行末まで削除
inoremap <silent> <C-d>0 <Esc>lc$
" カーソルから行頭までヤンク
inoremap <silent> <C-y>e <Esc>ly0<Insert>
" カーソルから行末までヤンク
inoremap <silent> <C-y>0 <Esc>ly$<Insert>
