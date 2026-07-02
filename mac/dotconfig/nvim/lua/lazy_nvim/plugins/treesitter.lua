return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        local parsers = {
            "cpp", "java", "c", "lua", "vim", "vimdoc", "sql", "latex", "markdown", "html", "comment", "yaml", "php",
            "css", "bash", "glsl", "kotlin", "tsx", "typescript", "javascript"
        }

        local filetypes = {
            "cpp", "java", "c", "lua", "vim", "vimdoc", "sql", "latex", "markdown", "html", "comment", "yaml", "php",
            "css", "bash", "sh", "glsl", "kotlin", "typescriptreact", "javascriptreact", "typescript", "javascript"
        }

        ts.setup({})
        ts.install(parsers)

        -- Treesitter features for installed languages must be enabled manually
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                -- Enable native Neovim treesitter highlighting
                vim.treesitter.start()

                -- Configure code folding
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo.foldmethod = "expr"
                vim.wo.foldlevel = 99

                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
