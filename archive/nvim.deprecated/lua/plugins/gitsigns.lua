local setup, gitsigns = pcall(require, "gitsigns")
if not setup then
    print("Could not import gitsigns in gitsigns.lua!")
    return
end

gitsigns.setup()
