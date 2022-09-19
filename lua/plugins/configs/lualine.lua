local _lualine, lualine = pcall(require, "lualine")
if not _lualine then
    return
end

local use_old_config = true
if not use_old_config then
  local _gps, gps = pcall(require, "nvim-gps")
  local gps_indicator = function()
    if _gps then
      return { gps.get_location, cond = gps.is_available }
    else return {}
    end
  end

  local _autosession, autosession = pcall(require, "nvim-autosession")
  local autosession_name = function()
    if _autosession then
      return autosession.current_session_name
    else return ""
    end
  end

  local theme_name = "auto"
  local _theme, theme = pcall(require, "theme")
  if _theme then
    theme_name = theme.theme_name
  end

  lualine.setup({
      options = {
          icons_enabled = true,
          theme = theme_name,
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true
      },
      -- Autosession plugin integration
      sections = {
          lualine_c = {
              autosession_name(),
              gps_indicator(),
              "lsp_progress"
          }
      }
  })
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local filename = {
  "filename",
  path=3, -- 0: just fn, 1: w/relative path, 2: abs path, 3: abs path with tilde for home
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon_only = true,
  colored = true,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = "", right = "" }, -- default: { left = '', right = ''},
    section_separators = { left = "", right = "" },  -- default: { left = '', right = ''},
    disabled_filetypes = {
      statusline = { "dashboard", "NvimTree", "Outline" }, -- default: {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { branch, diagnostics },                    -- default: {"mode"}
    lualine_b = { mode },                                   -- default: {"branch", "diff", "diagnostics"}
    lualine_c = { filename }, -- default: {"filename"}
    lualine_x = { diff, spaces, "encoding", "filetype" },     -- default: {"encoding", "fileformat", "filetype"}
    lualine_y = { "location" },                               -- default: {"progress"}
    lualine_z = { "progress" },                               -- default: {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
  },
  inactive_winbar = {
    -- lualine_a = { filename },
    -- lualine_b = { diff, spaces, "encoding", filetype },                                   -- default: {"branch", "diff", "diagnostics"}
    -- lualine_c = { "location" },                             -- default: {"filename"}
		lualine_a = { filetype, filename },
		lualine_b = { "location", "diagnostics" },
  },
  winbar = {
		lualine_a = { filetype, filename },
		lualine_b = { "location", "diagnostics" },
  },
  extensions = {},
})
