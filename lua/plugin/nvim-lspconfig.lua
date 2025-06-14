local function config()
    local on_attach = require("nvchad.configs.lspconfig").on_attach
    local capabilities = require("nvchad.configs.lspconfig").capabilities
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    -- Rust lsp config
    lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {"rust"},
        root_dir = util.root_pattern("Cargo.toml"),
        settings = {
            ['rust-analyzer'] = {
                cargo = {
                    allFeatures = true,
                },
            },
        },
    })

    lspconfig.lua_ls.setup({
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files and plugins
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        }
    })
end

return {
    "neovim/nvim-lspconfig",
    config = config,
    event = { "BufRead", "BufNewFile" },
}
