local autopairs_setup, autopairs = pcall(require, "autopairs")
if not autopairs_setup then
    print("Could not import autopairs in autopairs.lua!")
    return
end

-- configure autopairs
autopairs.setup({
    check_ts = true, -- enable treesitter
    ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        java = false, -- don't check treesitter on java
    },
})

local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_setup then
    print("Could not import nvim-autopairs.completion.cmp in autopairs.lua!")
    return
end

local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
    print("Could not import cmp in autopairs.lua!")
    return
end

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
