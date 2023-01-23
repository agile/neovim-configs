local ok, builtin = pcall(require, "telescope.builtin")
if not ok then
  return
end

vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git managed files" })
vim.keymap.set("n", "<leader>pg", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep files" })

-- local actions = require "telescope.actions"
--
-- telescope.setup {
--     picker = {
--         hidden = false,
--     },
--     defaults = {
--         -- prompt_prefix = " ",
--         -- selection_caret = " ",
--         vimgrep_arguments = {
--             "rg",
--             "--color=never",
--             "--no-heading",
--             "--with-filename",
--             "--line-number",
--             "--column",
--             "--no-ignore",
--             "--smart-case",
--             "--hidden",
--         },
--         file_ignore_patterns = { "/.git/","/.settings/", "/.metadata/", "/target/", "/node_modules/", '.class$' },
--         mappings = {
--             i = {
--                 ['<C-u>'] = false,
--                 ['<C-d>'] = false,
--
--                 -- ["<C-h>"] = actions.which_key,
--                 -- ["<C-n>"] = actions.cycle_history_next,
--                 -- ["<C-p>"] = actions.cycle_history_prev,
--
--                 -- ["<C-j>"] = actions.move_selection_next,
--                 -- ["<C-k>"] = actions.move_selection_previous,
--
--                 -- ["<C-c>"] = actions.close,
--
--                 -- ["<Down>"] = actions.move_selection_next,
--                 -- ["<Up>"] = actions.move_selection_previous,
--
--                 -- ["<CR>"] = actions.select_default,
--                 -- ["<C-x>"] = actions.select_horizontal,
--                 -- ["<C-v>"] = actions.select_vertical,
--                 -- ["<C-t>"] = actions.select_tab,
--
--                 -- ["<C-u>"] = actions.preview_scrolling_up,
--                 -- ["<C-d>"] = actions.preview_scrolling_down,
--
--                 -- ["<PageUp>"] = actions.results_scrolling_up,
--                 -- ["<PageDown>"] = actions.results_scrolling_down,
--
--                 -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
--                 -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
--                 -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
--                 -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--                 -- ["<C-l>"] = actions.complete_tag,
--                 -- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
--             },
--             n = {
--                 -- ["<esc>"] = actions.close,
--                 -- ["<CR>"] = actions.select_default,
--                 -- ["<C-x>"] = actions.select_horizontal,
--                 -- ["<C-v>"] = actions.select_vertical,
--                 -- ["<C-t>"] = actions.select_tab,
--
--                 -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
--                 -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
--                 -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
--                 -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--
--                 -- ["j"] = actions.move_selection_next,
--                 -- ["k"] = actions.move_selection_previous,
--                 -- ["H"] = actions.move_to_top,
--                 -- ["M"] = actions.move_to_middle,
--                 -- ["L"] = actions.move_to_bottom,
--
--                 -- ["<Down>"] = actions.move_selection_next,
--                 -- ["<Up>"] = actions.move_selection_previous,
--                 -- ["gg"] = actions.move_to_top,
--                 -- ["G"] = actions.move_to_bottom,
--
--                 -- ["<C-u>"] = actions.preview_scrolling_up,
--                 -- ["<C-d>"] = actions.preview_scrolling_down,
--
--                 -- ["<PageUp>"] = actions.results_scrolling_up,
--                 -- ["<PageDown>"] = actions.results_scrolling_down,
--
--                 -- ["?"] = actions.which_key,
--             },
--         },
--         layout_strategy = "horizontal",
--         file_sorter = require("telescope.sorters").get_fuzzy_file,
--         generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
--         path_display = { "absolute" }, -- { "smart" },
--         color_devicons = true,
--         use_less = true,
--         set_env = { ["COLORTERM"] = "truecolor" },
--         file_previewer = require("telescope.previewers").vim_buffer_cat.new,
--         grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
--         qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--         buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
--     },
--     extensions = {
--         fzf = {
--             fuzzy = true,
--             override_generic_sorter = true,
--             override_file_sorter = true,
--             case_mode = "smart_case",
--         }
--     }
-- }
--
-- telescope.load_extension "fzf"
