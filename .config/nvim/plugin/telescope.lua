local action_state = require "telescope.actions.state"
local fb = require('telescope').extensions.file_browser
local fb_utils = require "telescope._extensions.file_browser.utils"
local tab_and_browse_path = function(path)
	vim.cmd('tabe')
	fb.file_browser({ path = path, files = false })
end

local open_projects = function()
	tab_and_browse_path('~/work')
end

local open_blocks = function()
	tab_and_browse_path('~/work/blocks')
end

--- Change local working directory of nvim to the selected file/folder in |telescope-file-browser.picker.file_browser|.
--- And change current picker into a fuzzy file picker in selected folder.
---@param prompt_bufnr number: The prompt bufnr
local teleport = function(prompt_bufnr)
	local current_picker = action_state.get_current_picker(prompt_bufnr)
	local finder = current_picker.finder
	local entry_path = action_state.get_selected_entry().Path
	finder.path = entry_path:is_dir() and entry_path:absolute() or entry_path:parent():absolute()
	finder.cwd = finder.path
	vim.cmd('tcd ' .. finder.path)

	finder.files = true
	finder.add_dirs = false
	finder.depth = false

	fb_utils.redraw_border_title(current_picker)
	current_picker:refresh(finder, { reset_prompt = true, multi = current_picker._multi })
	fb_utils.notify(
		'action.teleport',
		{ msg = 'Teleported!', level = 'INFO', quiet = finder.quiet }
	)
end

local action_layout = require('telescope.actions.layout')
require('telescope').setup {
	defaults = {
		layout_config = { prompt_position = 'bottom', preview_width = 0.5 },
		mappings = {
			i = {
				['<C-h>'] = 'which_key',
				['<C-j>'] = 'move_selection_next',
				['<C-k>'] = 'move_selection_previous',
				['<C-p>'] = action_layout.toggle_preview
			},
			n = {
				['<C-p>'] = action_layout.toggle_preview
			}
		}
	},
	pickers = {
		buffers = {
			mappings = {
				i = {
					['<C-r>'] = 'delete_buffer'
				}
			}
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
		file_browser = {
			cwd_to_path = true,
			hide_parent_dir = true,
			display_stat = false,
			mappings = {
				['i'] = {
					['<C-l>'] = teleport
				}
			}
		}
	},
}

require('telescope').load_extension 'file_browser'

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>b', ':Telescope buffers<CR>', opts)
map('n', '<leader>p', ':Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>', opts)
map('n', '<leader>F', ':Telescope live_grep<CR>', opts)
map('n', '<leader>f', ':Telescope grep_string<CR>', opts)
map('n', '<leader>hh', ':Telescope oldfiles<CR>', opts)

map('n', '<leader>op', '', { callback = open_projects })
map('n', '<leader>ob', '', { callback = open_blocks })
