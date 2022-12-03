
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'elixir-editors/vim-elixir'
Plug 'itchyny/calendar.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-mix-format'
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
Plug 'wakatime/vim-wakatime'
" Plug 'chiedo/vim-case-convert'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-endwise'
Plug 'jgdavey/vim-blockle'
Plug 'wincent/terminus'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-dadbod'
Plug 'vim-test/vim-test'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'luukvbaal/nnn.nvim'
Plug 'pwntester/octo.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
" Plug 'dense-analysis/ale'
Plug 'L3MON4D3/LuaSnip'
Plug 'LukasPietzschmann/telescope-tabs'
Plug 'renerocksai/telekasten.nvim'

call plug#end()

lua << EOF

local builtin = require("nnn").builtin

require("nnn").setup( {
	mappings = {
		{ "<C-t>", builtin.open_in_tab },       -- open file(s) in tab
		{ "<C-s>", builtin.open_in_split },     -- open file(s) in split
		{ "<C-v>", builtin.open_in_vsplit },    -- open file(s) in vertical split
		{ "<C-p>", builtin.open_in_preview },   -- open file in preview split keeping nnn focused
		{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
		{ "<C-w>", builtin.cd_to_path },        -- cd to file directory
		{ "<C-e>", builtin.populate_cmdline },  -- populate cmdline (:) with file(s)
	},
	picker = { style = { width = 0.2, height = 0.5, border = "none" } }
}
)

require"octo".setup()
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

-- Built-in actions
local transform_mod = require('telescope.actions.mt').transform_mod

local my_actions = transform_mod({
  open_new_tmux_window = function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- print(vim.inspect(selection))
		vim.cmd(string.format('silent !tmux new-window -c ~/work/%s nvim', selection[1]))
		actions.close(prompt_bufnr)
  end,
})

blocks = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = 'blocks applications',
	default_selection_index = 0,
    finder = finders.new_table {
      results = opts['list']
    },
    sorter = conf.generic_sorter(opts),
	attach_mappings = function(prompt_bufnr, map)
		actions.select_default:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(string.format('lcd %s/%s', opts["base_path"], selection[1]))
		end)
		actions.select_tab:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(string.format('tabe | lcd %s/%s', opts["base_path"], selection[1]))
		end)
		actions.do_stuff = my_actions.open_new_tmux_window

		map('n', '<C-o>', actions.do_stuff)
		map('i', '<C-o>', actions.do_stuff)
		return true
	end,
  }):find()
end

projects = function(opts)
  opts = opts or { '--files' }
  pickers.new(opts, {
    prompt_title = 'blocks applications',
	default_selection_index = 0,
	track = true,
	finder = finders.new_oneshot_job { "rg", opts },
    sorter = conf.generic_sorter(opts),
	attach_mappings = function(prompt_bufnr, map)
		actions.select_default:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(string.format('lcd ~/work/%s', selection[1]))
		end)
		actions.select_tab:replace(function()
			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			vim.cmd(string.format('tabe | lcd ~/work/%s', selection[1]))
		end)
		actions.do_stuff = my_actions.open_new_tmux_window

		map('n', '<C-o>', actions.do_stuff)
		map('i', '<C-o>', actions.do_stuff)
		return true
	end,
  }):find()
end

local action_layout = require("telescope.actions.layout")
require('telescope').setup{
defaults = {
	layout_config = { prompt_position = 'bottom', preview_width = 0.5 },
	mappings = {
		i = {
			["<C-h>"] = "which_key",
			["<C-j>"] = "move_selection_next",
			["<C-j>"] = "move_selection_next",
			["<C-k>"] = "move_selection_previous",
			["<C-p>"] = action_layout.toggle_preview
			},
		n = {
			["<C-p>"] = action_layout.toggle_preview
			}
		}
	},
extensions = {
	fzf = {
		fuzzy = true,
		override_generic_sorter = true,
		override_file_sorter = true,
		case_mode = "smart_case",
		}
	}
}

local ls = require"luasnip"
local i = ls.insert_node
local t = ls.text_node
local s = ls.snippet

ls.add_snippets("all", {
	s("ternary", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	})
})

ls.add_snippets("ruby", {
	s("test", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		t("test '"), i(1, "desc"), t({"' do", ""}), i(0, ""), t({"", "end"})
	})
})

local home = vim.fn.expand("~/zettelkasten")
require('telekasten').setup({ home = home })
EOF

nnoremap <silent> <Leader>oc :Octo actions<CR>

"numbers
set nu
set relativenumber
set numberwidth=1
set showcmd
set autoread

"cursor position
set so=999

set incsearch
set splitright splitbelow

set updatetime=100

set cursorline
set textwidth=120
set colorcolumn=+1
set laststatus=2
set shiftwidth=4
set tabstop=4

set nohidden

set wildmenu
set wildmode=longest:full

autocmd BufWritePre * :%s/\s\+$//e
autocmd TermOpen * startinsert
autocmd User FugitiveEditor set spell
autocmd BufReadPost,BufNewFile calcurse-note.*,*.md,*.txt setlocal spell
" autocmd BufWritePost *.rb silent! !~/.git_template/hooks/ctags

highlight linenr term=bold cterm=NONE ctermfg=darkgrey ctermbg=NONE
highlight! link signcolumn linenr
highlight colorcolumn ctermbg=darkgrey
highlight NormalFloat ctermbg=NONE ctermfg=NONE

"cursor in different modes
"https://vim.fandom.com/wiki/change_cursor_shape_in_different_modes
let &t_si = "\<esc>]50;cursorshape=1\x7"
let &t_sr = "\<esc>]50;cursorshape=2\x7"
let &t_ei = "\<esc>]50;cursorshape=0\x7"

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

source ~/.cache/calendar.vim/credentials.vim

nnoremap <silent> <Leader>cl :Calendar -view=clock -split=vertical
			\ -position=right -width=27<CR>

nnoremap <silent> <Leader>sc :Calendar -view=day -split=vertical -width=27<CR>

" let g:airline_skip_empty_sections = 1
let g:airline_section_c_only_filename = 0
" let g:airline_left_sep='»'
let g:airline_left_sep=''
" let g:airline_right_sep='«'
let g:airline_right_sep=''
" let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_a = ''
let g:airline_section_b = ''
" let g:airline_section_c = '%f'
" let g:airline_section_c = airline#section#create(['%f%m', ' ', 'readonly', 'coc_status', 'lsp_progress'])
let g:airline_section_c = airline#section#create(['%f%m', ' ', 'readonly'])
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = 'col: %{col(".")}, last line: %L'
let g:airline_theme='simple'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_close_button = 0

function! InactiveWindow(...)
	let builder = a:1
	" let context = a:2
	call builder.add_section('airline_a', '%{tabpagewinnr(tabpagenr())}')
	call builder.add_section('airline_b', '%f%m')
	return 1
endfunction
call airline#add_inactive_statusline_func('InactiveWindow')
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

let g:blockle_mapping = '<Leader>rb'

" Maximizer
nnoremap <silent> <Leader>m :MaximizerToggle<CR>

" Ranger

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
let g:highlightedyank_highlight_duration = 150

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 70

" Draw border with both
" let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'

" Map Rnvimr action
let g:rnvimr_action = {
			\ '<C-t>': 'NvimEdit tabedit',
			\ '<C-x>': 'NvimEdit split',
			\ '<C-v>': 'NvimEdit vsplit',
			\ 'gw': 'JumpNvimCwd',
			\ 'yw': 'EmitRangerCwd'
			\ }
" let g:rnvimr_vanilla = 1
"
" let g:ranger_map_keys = 0
" map <leader>r :RnvimrToggle<CR>
"

" Limelight
map <Leader>L :Limelight!!<cr>

" Highlight yank
let g:highlightedyank_highlight_duration = 200

"Rubocop
let g:vimrubocop_keymap = 0
nmap <silent> <Leader>ru :update <CR>:RuboCop -A<CR>
nmap <silent> <Leader>Ru term://rubocop -A<CR>

" Own
nnoremap <Leader>sk :e ~/.skhdrc<CR>
nnoremap <Leader>rc :e $MYVIMRC<CR>
nnoremap <Leader>so :so $MYVIMRC<CR>
" nnoremap <Leader>pi :PlugInstall<CR>
" nnoremap <Leader>pu :PlugUpdate<CR>
" nnoremap <Leader>pc :PlugClean<CR>

nnoremap <Leader>vt :vsp term://fish<CR>
nnoremap <Leader>st :sp term://fish<CR>
nnoremap <Leader>ct :term<CR>

" nnoremap <Leader>ve :Vexp<CR>
" nnoremap <Leader>se :Sex<CR>
map <leader>e :NnnPicker %:p:h<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>qa :qa<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>Qa :qa!<CR>
nnoremap <Leader>E :e!<CR>

nnoremap <Leader>sd :w<CR> :bd<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader>D :bd!<CR>
nnoremap <Leader>n :noh<CR>

nnoremap <Leader>bi obinding.pry<Esc> :update<CR>
nnoremap <Leader>bI Obinding.pry<Esc> :update<CR>
nmap <Leader>bu :sp term://bundle<CR>
nmap <Leader>rs :sp term://rails c<CR>
nmap <Leader>rr :silent !touch tmp/restart.txt<CR>

nnoremap <Leader>to :rightbelow vsp +$ ~/todo.md<CR>

" nnoremap <Leader>op :Op ../
nnoremap <Leader>op :lua blocks({ ['base_path'] = '~/work', ['list'] = { 'blocks', 'dpg-learning', 'adidas-learning', 'loyensloeff', 'vodafone-ziggo-learning', 'wbcsd-learning', 'mkb-cybertraining' } })<CR>
nnoremap <Leader>ob :lua blocks({ ['base_path'] = '~/work/blocks', ['list'] = { 'core', 'trainings', 'occassions', 'media', 'api' , 'events', 'traces', 'magazine', 'admin', 'omniauth', 'scorm' } })<CR>
" nnoremap <Leader>op :lua projects()<CR>
" nnoremap <Leader>op :lua blocks(require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{}))<CR>

" abbreviations
ab bcore Blocks::Core::
ab bmed Blocks::Media::

ab ag Ammar Ghaus
ab am ammar

" Goyo
let g:goyo_width = 125
nnoremap <Leader>gy :Goyo<CR> :so $MYVIMRC<CR>

" telescopes
nnoremap <silent> <Leader>b <cmd>Telescope buffers<CR>
nnoremap <silent> <Leader>p <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
nnoremap <silent> <Leader>F <cmd>Telescope live_grep<CR>
nnoremap <silent> <Leader>f <cmd>Telescope grep_string<CR>
nnoremap <silent> <Leader>g <cmd>G log<CR>
nnoremap <silent> <Leader>gl <cmd>G log %<CR>
nnoremap <silent> <Leader>hh <cmd>Telescope oldfiles<CR>
nnoremap <silent> <Leader>h: <cmd>Telescope command_history<CR>
nnoremap <silent> <Leader>h/ <cmd>Telescope search_history<CR>
nnoremap <silent> <Leader>ot <cmd>Telescope telescope-tabs list_tabs<CR>

nnoremap <Leader>gs <cmd>:G<CR>
nnoremap <Leader>br <cmd>:G branch<CR>


" Fugitive
" nnoremap <Leader>gs :G<CR>
nnoremap <Leader>gd :G diff %<CR>
nnoremap <Leader>gb :GBrowse<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gc :G commit<CR>
nnoremap <Leader>gz :G stash<CR>
nnoremap <Leader>gzp :G stash pop<CR>
nnoremap <Leader>ge :G commit --amend --no-edit<CR>
nnoremap <Leader>gp :G pull --rebase<CR>
nnoremap <Leader>gP :G push<CR>
nnoremap <Leader>gPf :G push --force-with-lease<CR>
" nnoremap <Leader>br :Merginal<CR>
" nnoremap <Leader>br :GBranches --remotes<CR>
nnoremap <Leader>bl :GBranches --locals<CR>
nnoremap <Leader>pr :silent !hub pr show<CR>:redraw!<CR>
nmap <Leader>ci :sp term://hub ci-status -v<CR>

"test
" make test commands execute using dispatch.vim
let test#strategy = "neovim"
let test#neovim#term_position = "botright 30"
" let test#strategy = "dispatch_background"
" let test#vim#term_position = "bo 10"
" let g:test#neovim#start_normal = 1 " If using neovim strategy
" let g:test#basic#start_normal = 1 " If using basic strategy

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tw <C-w>o:TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" links to open

nnoremap <Leader>bp :silent !open "https://github.com/orgs/nerds-and-company/packages?repo_name=blocks"<CR>
nnoremap <Leader>ji :silent !jira open<CR>

" slack
command! Slack :call slim#StartSlack()

" commands
command Bp norm ^f-wye2f'Cpath: '../blocks/<C-r>0'<Esc>:update<CR>
command Nd norm ]<space>jo# <C-r>=strftime("%b %d")<CR>
command Ct silent !~/.git_template/hooks/ctags

command -nargs=1 -complete=file Op tabe|lcd <args>

" lsp
lua << EOF
require'lspconfig'.solargraph.setup{
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			'n',
			'<space>f',
			'<cmd>lua vim.lsp.buf.format { async = true }<CR>',
			{ noremap=true, silent=true })
	end
	}
EOF
nnoremap <Leader>l :lua vim.diagnostic.disable()<CR>
nnoremap <Leader>ll :lua vim.diagnostic.enable()<CR>

function! Rooter()
	let cd = expand('%:p:h')
	let command = "pathfinder ".cd." Gemfile | head -n 1 | awk -F/Gemfile '{print $1}'"
	let dir = system(command)
	execute 'lcd' system(command)
endfunction

function! PRooter()
	let cd = expand('%:p:h')
	let command = "pathfinder ".cd." Gemfile | head -n 2 | tail -1 | awk -F/Gemfile '{print $1}'"
	let dir = system(command)
	execute 'lcd' system(command)
endfunction

nnoremap <Leader>r :call Rooter()<CR>
nnoremap <Leader>R :call PRooter()<CR>

" snippets
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
