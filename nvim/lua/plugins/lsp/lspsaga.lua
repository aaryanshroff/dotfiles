local setup, saga = pcall(require, "lspsaga")
if not setup then
    print("Could not import lspsaga in lspsaga.lua!")
    return
end

saga.setup({
    -- keybinds for navigation in lspsaga window
    move_in_saga = { prev = "<C-k>", next = "<C-j>" },
    -- use enter to open file with finder
    finder_action_keys = {
        open = "<CR>",
    },
    -- use enter to open file with definition preview
    definition_action_keys = {
        edit = "<CR>",
    },
})
