
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/528
--[[ local if_available = function(builtin)
    local command = builtin._opts.command
    builtin.condition = function()
        return vim.fn.executable(command) > 0
    end
    return builtin
end ]]

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    -- bleh.. needs pylint >= 2.4.. need to get our old deps bumped up before I can use this
    -- diagnostics.pylint.with({
    --   condition = function(utils)
    --     return utils.root_has_file({ ".pylintrc"})
    --   end
    -- }),
  },
}
