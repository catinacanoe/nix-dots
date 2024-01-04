{ pkgs, plugins, ... }:
let
    config = /* lua */ ''{
        "neovim/nvim-lspconfig",

        lazy = false,

        config = function(_, _)
            vim.keymap.set("n", "<space>ei", vim.diagnostic.open_float)
            vim.keymap.set("n", "<space>en", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "<space>eo", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>ef", vim.cmd.Neoformat)

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    vim.keymap.set("n", "<cr>", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
                    -- (covered by telescope) vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                    vim.keymap.set("n", "I", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "A", vim.lsp.buf.signature_help, opts)

                    vim.keymap.set("n", "<leader>er", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ea", vim.lsp.buf.code_action, opts)

                    -- vim.lsp.buf.format { async = true }
                end,
            })

            vim.diagnostic.config {
                virtual_text = true,
                float = {
                    border = "rounded"
                }
            }
            
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = "rounded"
                }
            )

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, {
                    border = "rounded"
                }
            )

            require('lspconfig.ui.windows').default_options = {
                border = "rounded"
            }

            local lspconf = require("lspconfig")
            local args = { capabilities = require("cmp_nvim_lsp").default_capabilities() }

            lspconf.nil_ls.setup(args)
            lspconf.lua_ls.setup(args)
            lspconf.bashls.setup(args)

            require("lint").linters_by_ft = {
                nix = {'nix'},
                lua = {'luacheck'},
                zsh = {'zsh'},
            }

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function() require("lint").try_lint() end,
            })

            vim.keymap.set("n", "<leader>el", require("lint").try_lint)
        end,

        dependencies = {
            "sbdchd/neoformat",
            "mfussenegger/nvim-lint",
        },
    }'';
in {
    plugin."${plugins}/lspconfig.lua".text = "return {${config}}";

    dependencies = with pkgs; [
        nil alejandra nixfmt
        lua-language-server stylua lua54Packages.luacheck
        nodePackages_latest.bash-language-server shfmt zsh
    ];
}
