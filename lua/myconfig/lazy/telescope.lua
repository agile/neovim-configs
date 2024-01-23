return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "otavioschwanck/telescope-alternate",
    --{
    --  "nvim-telescope/telescope-fzf-native.nvim",
    --  build =
    --  "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    --}
  },
  config = function()
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<C-t>", builtin.builtin, { desc = "Telescope" })
    vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Telescope Live grep" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope Find git managed files" })
    vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>pg", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "Grep files" })

    require("telescope").setup({
      picker = {
        hidden = false,
      },
      defaults = {
        -- -- prompt_prefix = " ",
        -- -- selection_caret = " ",
        -- vimgrep_arguments = {
        --     "rg",
        --     "--color=never",
        --     "--no-heading",
        --     "--with-filename",
        --     "--line-number",
        --     "--column",
        --     "--no-ignore",
        --     "--smart-case",
        --     "--hidden",
        -- },
        -- file_ignore_patterns = { "/.git/","/.settings/", "/.metadata/", "/target/", "/node_modules/", '.class$' },
        -- layout_strategy = "horizontal",
        -- file_sorter = require("telescope.sorters").get_fuzzy_file,
        -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        -- path_display = { "absolute" }, -- { "smart" },
        -- color_devicons = true,
        -- use_less = true,
        -- set_env = { ["COLORTERM"] = "truecolor" },
        -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
      extensions = {
        -- fzf = {
        --   fuzzy = true,
        --   override_generic_sorter = true,
        --   override_file_sorter = true,
        --   case_mode = "smart_case",
        -- }
        -- ["telescope-alternate"] = {
        --   mappings = {
        --     { 'app/services/(.*)_services/(.*).rb', {                                                          -- alternate from services to contracts / models
        --       { 'app/contracts/[1]_contracts/[2].rb', 'Contract' },                                            -- Adding label to switch
        --       { 'app/models/**/*[1].rb',              'Model',   true },                                       -- Ignore create entry (with true)
        --     } },
        --     { 'app/contracts/(.*)_contracts/(.*).rb', { { 'app/services/[1]_services/[2].rb', 'Service' } } }, -- from contracts to services
        --     -- Search anything on helper folder that contains pluralize version of model.
        --     --Example: app/models/user.rb -> app/helpers/foo/bar/my_users_helper.rb
        --     { 'app/models/(.*).rb',                   { { 'db/helpers/**/*[1:pluralize]*.rb', 'Helper' } } },
        --     { 'app/**/*.rb',                          { { 'spec/[1].rb', 'Test' } } }, -- Alternate between file and test
        --   },
        --   presets = { 'rails', 'rspec', 'nestjs', 'angular' },                         -- Telescope pre-defined mapping presets
        --   open_only_one_with = 'current_pane',                                         -- when just have only possible file, open it with.  Can also be horizontal_split and vertical_split
        --   -- transformers = {                                                             -- custom transformers
        --   --   change_to_uppercase = function(w) return my_uppercase_method(w) end
        --   -- },
        --   -- telescope_mappings = { -- Change the telescope mappings
        --   --   i = {
        --   --     open_current = '<CR>',
        --   --     open_horizontal = '<C-s>',
        --   --     open_vertical = '<C-v>',
        --   --     open_tab = '<C-t>',
        --   --   },
        --   --   n = {
        --   --     open_current = '<CR>',
        --   --     open_horizontal = '<C-s>',
        --   --     open_vertical = '<C-v>',
        --   --     open_tab = '<C-t>',
        --   --   }
        --   -- }
        -- },
      }
    })

    -- require("telescope").load_extension("fzf")
  end
}


-- require('telescope-alternate').setup({
--   mappings = {
--     { 'app/services/(.*)_services/(.*).rb', {                                                          -- alternate from services to contracts / models
--       { 'app/contracts/[1]_contracts/[2].rb', 'Contract' },                                            -- Adding label to switch
--       { 'app/models/**/*[1].rb',              'Model',   true },                                       -- Ignore create entry (with true)
--     } },
--     { 'app/contracts/(.*)_contracts/(.*).rb', { { 'app/services/[1]_services/[2].rb', 'Service' } } }, -- from contracts to services
--     -- Search anything on helper folder that contains pluralize version of model.
--     --Example: app/models/user.rb -> app/helpers/foo/bar/my_users_helper.rb
--     { 'app/models/(.*).rb',                   { { 'db/helpers/**/*[1:pluralize]*.rb', 'Helper' } } },
--     { 'app/**/*.rb',                          { { 'spec/[1].rb', 'Test' } } }, -- Alternate between file and test
--   },
--   presets = { 'rails', 'rspec', 'nestjs', 'angular' },                         -- Telescope pre-defined mapping presets
--   open_only_one_with = 'current_pane',                                         -- when just have only possible file, open it with.  Can also be horizontal_split and vertical_split
--   transformers = {                                                             -- custom transformers
--     change_to_uppercase = function(w) return my_uppercase_method(w) end
--   },
--   -- telescope_mappings = { -- Change the telescope mappings
--   --   i = {
--   --     open_current = '<CR>',
--   --     open_horizontal = '<C-s>',
--   --     open_vertical = '<C-v>',
--   --     open_tab = '<C-t>',
--   --   },
--   --   n = {
--   --     open_current = '<CR>',
--   --     open_horizontal = '<C-s>',
--   --     open_vertical = '<C-v>',
--   --     open_tab = '<C-t>',
--   --   }
--   -- }
-- })
--
-- -- On your telescope:
-- require('telescope').load_extension('telescope-alternate')
--
--
-- -- You alternatively can call the setup inside telescope:
-- require('telescope').setup {
--   extensions = {
--     ["telescope-alternate"] = {
--       mappings = {
--         ...your mappings
--       },
--       presets = { 'rails', 'nestjs' }
--     },
--   },
-- }
--
-- -- You also can use the verbose way to mapping:
-- mappings = {
--   {
--     pattern = 'app/services/(.*)_services/(.*).rb',
--     targets = {
--       { template = 'app/contracts/[1]_contracts/[2].rb', label = 'Contract', enable_new = true } -- enable_new can be a function too.
--     }
--   },
--   {
--     pattern = 'app/contracts/(.*)_contracts/(.*).rb',
--     targets = {
--       { template = 'app/services/[1]_services/[2].rb', label = 'Service', enable_new = true }
--     }
--   },
-- }
