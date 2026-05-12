return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        local languages = {
            "cpp", "java", "c", "lua", "vim", "vimdoc", "sql", "latex", "markdown", "html", "comment", "yaml", "php",
            "css", "bash", "glsl", "kotlin"
        }

        ts.setup({})
        ts.install(languages)

        -- Treesitter features for installed languages must be enabled manually
        vim.api.nvim_create_autocmd("FileType", {
            pattern = languages,
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
