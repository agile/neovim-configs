local ok, saga = pcall(require, "lspsaga")
if not ok then
    return
end

-- see https://github.com/glepnir/lspsaga.nvim#configuration
saga.init_lsp_saga(
    {
        code_action_lightbulb = {
            enable = false,
            sign = true,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = true,
        },
    })
