"         __                    _   __         _    ________  ___
"  ____  / /_  ____ ___  __  __/ | / /__  ____| |  / /  _/  |/  /
" / __ \/ __ \/ __ `__ \/ / / /  |/ / _ \/ __ \ | / // // /|_/ /
"/ /_/ / / / / / / / / / /_/ / /|  /  __/ /_/ / |/ // // /  / /
"\____/_/ /_/_/ /_/ /_/\__, /_/ |_/\___/\____/|___/___/_/  /_/
"                     /____/
" 
" init.vim
"
" 2022 (vimscript) v1nd1c4t1on
" 

" highlight

set t_Co=256
syntax on
let &t_ut=''

" open the line number

set number

" show a line

set cursorline
set wrap
set showcmd
set wildmenu

" tabe

map tn :tabe<CR>
map tj :-tabnext<CR>
map tl :+tabnext<CR>

" Move

noremap i k
noremap k j
noremap j h
noremap h i
noremap I 6k
noremap K 6j
noremap H I

" File Action

map s <nop>
map S :w<CR>
map Q :q<CR>
map ! :q!<CR>
noremap U u
map u <nop>

" indentation

filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
set scrolloff=5
set backspace=indent,eol,start

" split the window
map sl :set splitright<CR>:vsplit<CR>
map sj :set nosplitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

map <SPACE>i <C-w>k
map <SPACE>k <C-w>j
map <SPACE>j <C-w>h
map <SPACE>l <C-w>l


" Spelling Check with <space>sc
map <LEADER>sc :set spell!<CR>

" reload the vimrc
map re :source $VIMRC<CR>

" the paste bug, the way to enter the paste mod
map <LEADER>p :set paste<CR>
map <LEADER>e :set nopaste<CR>
set clipboard=unnamedplus

" Control buffers

map X  :bd<CR>
map gj :bp<CR>
map gl :bn<CR>

set nocompatible

" >>> Amazing Plugs <<<
call plug#begin('~/.config/nvim/plugged')

" scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" lualine
Plug 'nvim-lualine/lualine.nvim'

" bufferline
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" File navigation
Plug 'kyazdani42/nvim-tree.lua'

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" Taglist
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }
 
" Bookmarks
Plug 'kshenoy/vim-signature'

" Error checking
Plug 'w0rp/ale'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" gas
Plug 'shirk/vim-gas'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" lang
Plug 'sheerun/vim-polyglot'

" template
Plug 'aperezdc/vim-template'

call plug#end()


" >>> Scheme <<<

let g:lightline = {'colorscheme': 'tokyonight'}
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
let g:tokyonight_transparent = 1

let g:tokyonight_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

colorscheme tokyonight


" >>> LuaLine <<<

lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

require("bufferline").setup{}

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  git = {
        enable = false
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require'nvim-web-devicons'.get_icons()
END

" >>> NERDtree <<<

map tt :NvimTreeToggle<CR>

set encoding=UTF-8
" >>> Coc <<<<

let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-clangd', 'coc-marketplace']

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent>fd :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" color
" hi CocMenuSel ctermfg=235 ctermbg=203

" >>> Tagbar <<<
 
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Chapter',
        \ 'i:Section',
        \ 'k:Paragraph',
        \ 'j:Subparagraph'
    \ ]
\ }


" >>> ale <<<
let g:ale_linters = {'asm': ['i686-elf-gcc'], 'c': [], 'hs': ['glc'], 'h': []}

" >>> vim template <<<
let g:templates_directory = '/home/gigalo/.vim/templates'
