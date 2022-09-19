local ok, dapui = pcall(require, "dapui")
if not ok then
    return
end

-- see https://github.com/nvim-telescope/telescope-dap.nvim

require("telescope").load_extension("dap")
