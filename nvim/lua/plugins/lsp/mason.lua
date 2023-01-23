local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
    print("Could not load mason-null-ls in mason.lua")
    return
end

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        "clangd",
        "cmake",
        "cssls",
        "dockerls",
        "emmet_ls",
        "gopls",
        "html",
        "pyright",
        "sumneko_lua",
        "tailwindcss",
        "terraformls",
        "tsserver",
    },

    automatic_installation = true
})

mason_null_ls.setup({
    ensure_installed = {
        "autopep8", -- python
        "black", -- python
        "clang_format", -- c, cpp, objc, objcpp
        "prettier", -- html, css, json, yaml, markdown, graphql, vue, svelte, typescript, javascript, scss, less, css, json, yaml, markdown, graphql, vue, svelte
        "eslint", -- javascript, typescript, javascriptreact, typescriptreact
        "gofumpt", -- go
        "goimports", -- go
        "stylelint",
        "shellcheck",
        "markdownlint",
        "luafmt",
        "terraform_docs",
        "terraform_fmt",
    },

    automatic_installation = true
})
