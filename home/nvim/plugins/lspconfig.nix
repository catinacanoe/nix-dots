{ pkgs, ... }:
{
    plugin = {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        type = "lua";
        config = /* lua */ ''
        vim.keymap.set("n", "<space>ei", vim.diagnostic.open_float)
        vim.keymap.set("n", "<space>en", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "<space>eo", vim.diagnostic.goto_next)

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }

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
        local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

        lspconf.nil_ls.setup{capabilities = cmp_caps}
        lspconf.lua_ls.setup{capabilities = cmp_caps}
        lspconf.bashls.setup{capabilities = cmp_caps}
    '';
    };

    packages = with pkgs; [
        nil
        lua-language-server
        nodePackages_latest.bash-language-server
    ];
}
