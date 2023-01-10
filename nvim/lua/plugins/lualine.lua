local status, lualine = pcall(require, "lualine")
if not status then
    print("Could not import lualine in lualine.lua!")   
    return
end

lualine.setup({
    options = {
        theme = "tokyonight"
    }
})
