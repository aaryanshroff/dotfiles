local setup, null_ls = pcall(require, "null-ls")
if not setup then
    print("Could not load null-ls in null-ls.lua")
    return
end

local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    -- setup formatters & linters
    sources = {
        formatting.prettier, -- js/ts formatter
        formatting.stylua, -- lua formatter
        formatting.clang_format, -- c/c++ formatter
        diagnostics.eslint_d.with({ -- js/ts linter
            -- only enable eslint if root has .eslintrc.js 
            condition = function(utils)
                return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
            end,
        }),
    },
    -- configure format on save
    on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(client)
                            --  only use null-ls for formatting instead of lsp server
                            return client.name == "null-ls"
                        end,
                        bufnr = bufnr,
                    })
                end,
            })
        end
    end,
})
