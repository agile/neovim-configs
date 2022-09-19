local ok, todo = pcall(require, "todo-comments")
if not ok then
    return
end

-- see https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
todo.setup {}
