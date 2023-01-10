local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then

    return
end

-- configure treesitter
treesitter.setup({
    -- enable syntax highlighting
    highlight = {
        enable = true,
    },
    -- enable indentation
    indent = { enable = true },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = { enable = true },
    -- ensure these language parsers are installed
    ensure_installed = {
        "bash",
        "cpp",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "graphql",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "python",
        "terraform",
        "tsx",
        "typescript",
        "yaml",
        "vim",
    },
    -- auto install above language parsers
    auto_install = true,
})
