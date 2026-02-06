-- set cursor color
vim.g.tokyonight_cursor = "green"

local status, _ = pcall(vim.cmd, "colorscheme tokyonight-moon")
if not status then
  print("Colorscheme not found!")
  return
end
