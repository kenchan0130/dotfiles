let $DEIN_INSTALL_DIRECTORY = $HOME.'/.vim/bundles'
let $BREW_PREFIX = trim(system('brew --prefix'))
let g:python3_host_prog = $BREW_PREFIX.'/bin/python3'
let g:python_host_prog = '/usr/bin/python'

if &compatible
  " Be iMproved
  set nocompatible
endif

" dein Required:
execute 'set runtimepath+='.$DEIN_INSTALL_DIRECTORY.'/repos/github.com/Shougo/dein.vim'

" dein Required:
call dein#begin(expand($DEIN_INSTALL_DIRECTORY))

" Let dein manage dein
" dein Required:
call dein#add(expand($DEIN_INSTALL_DIRECTORY.'/repos/github.com/Shougo/dein.vim'))

" dein plguins
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/defx.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('prabirshrestha/vim-lsp')
call dein#add('lighttiger2505/deoplete-vim-lsp')
call dein#add('markonm/traces.vim')
call dein#add('machakann/vim-highlightedyank')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('cohama/lexima.vim')
" replace match with 'sc' key bind
call dein#add('tpope/vim-surround')
" move match with '%' key bind
call dein#add('andymass/vim-matchup')

" dein Required:
call dein#end()

" dein Required:
filetype plugin indent on
syntax enable

" deinプラグインでインストールが必要なものがあればインストール
if dein#check_install()
  call dein#install()
endif

" """ ============= denite key bind =================
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> a
  \ denite#do_map('open_filter_buffer')
endfunction

" """ ============= defx.nvim key bind =================
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> T
  \ defx#do_action('open','tabnew')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('drop', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('open_tree', 'recursive:1')
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

" defx settings
autocmd VimEnter * execute 'Defx'
nnoremap <silent> <Leader>f :<C-u> Defx <CR>

call defx#custom#option('_', {
  \ 'winwidth': 40,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 1,
  \ 'buffer_name': 'exproler',
  \ 'toggle': 1,
  \ 'resume': 1,
  \ })
autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()

" deoplete settings
call deoplete#enable()
call deoplete#custom#option('ignore_case', v:true)
call deoplete#custom#option('smart_case', v:true)

"" deoplete shortcut keys
""" <TAB>: completion.
inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
""" <S-TAB>: completion back.
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
""" <C-e>: popup cancel
inoremap <expr><C-e> deoplete#cancel_popup()

" denite settings
"" custom variables
if executable('rg')
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git', '--color', 'never'])
  call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git', '--color', 'never'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
endif

"" denite shortcut keys
nmap <Space> [denite]
nmap <Space>p [deniteProject]
nmap <silent> [denite]b :<C-u>Denite buffer<CR>
nmap <silent> [denite]g :<C-u>Denite grep<CR>
nmap <silent> [denite]m :<C-u>Denite file_mru<CR> <silent> <C-u><C-y> :<C-u>Denite neoyank<CR>
nmap <silent> [denite]f :<C-u>Denite file/rec<CR>
nmap <silent> [denite]d :<C-u>Denite directory_rec<CR>

nmap <silent> [deniteProject]b :<C-u>DeniteProject buffer<CR>
nmap <silent> [deniteProject]g :<C-u>DeniteProject grep<CR>
nmap <silent> [deniteProject]m :<C-u>DeniteProject file_mru<CR> <silent> <C-u><C-y> :<C-u>Denite neoyank<CR>
nmap <silent> [deniteProject]f :<C-u>DeniteProject file/rec<CR>
nmap <silent> [deniteProject]d :<C-u>DeniteProject directory_rec<CR>

call denite#custom#option('default', 'prompt', '>')
call denite#custom#map('insert', '<Tab>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<S-Tab>', '<denite:move_to_previous_line>')


" neosnippet
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
"" disable neosnippeet preview
set completeopt-=preview

" vim-highlightedyank settings
let g:highlightedyank_highlight_duration = 100

" vim-indent-guides settings
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=238
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" ============= denite.nvim end =================

set wildmenu

" マウス操作を許可
set mouse=a

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

" 行頭・行末移動方向をキーの相対位置にあわせる
nnoremap 0 $
nnoremap 1 0

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Ruby
autocmd BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.erb set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.thor set nowrap tabstop=2 shiftwidth=2 softtabstop=2 filetype=ruby
autocmd BufNewFile,BufRead *file,!Dockerfile set nowrap tabstop=2 shiftwidth=2 softtabstop=2 filetype=ruby
autocmd BufNewFile,BufRead Movefile set nowrap tabstop=2 shiftwidth=2 softtabstop=2 filetype=yaml

" YAML
autocmd BufNewFile,BufRead *.yml set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.yaml set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" CoffeeScript
autocmd BufNewFile,BufRead *.coffee set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" HTML
autocmd BufNewFile,BufRead *.html set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" JavaScript
autocmd BufNewFile,BufRead *.js set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" SCSS/SASS
autocmd BufNewFile,BufRead *.scss set nowrap tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.sass set nowrap tabstop=2 shiftwidth=2 softtabstop=2

" PHP
autocmd BufNewFile,BufRead *.php set nowrap noexpandtab tabstop=2 shiftwidth=2 softtabstop=2
