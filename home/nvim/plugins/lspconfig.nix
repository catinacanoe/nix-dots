{ pkgs, plugins, rice, ... }:
let
    config = /* lua */ ''{
        "neovim/nvim-lspconfig",

        lazy = false,

        config = function(_, _)
            vim.keymap.set("n", "<space>ei", vim.diagnostic.open_float)
            vim.keymap.set("n", "<space>en", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "<space>eo", vim.diagnostic.goto_next)
            -- vim.keymap.set("n", "<space>ef", vim.cmd.Neoformat)

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

            local bordertype = "${if rice.style.rounding then "rounded" else "single"}"

            vim.diagnostic.config {
                virtual_text = true,
                float = {
                    border = bordertype
                }
            }
            
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = bordertype
                }
            )

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, {
                    border = bordertype
                }
            )

            vim.lsp.enable('nil_ls')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('bash_ls')

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

            require("lsp_lines").setup()
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = true,
                update_in_insert = true,
            })
        end,

        dependencies = {
            "sbdchd/neoformat",
            "mfussenegger/nvim-lint",
            "Maan2003/lsp_lines.nvim",
        },
    }'';
in {
    plugin."${plugins}/lspconfig.lua".text = "return {${config}}";

    dependencies = with pkgs; [
        nil alejandra nixfmt-rfc-style
        lua-language-server stylua lua54Packages.luacheck
        nodePackages_latest.bash-language-server shfmt zsh
    ];
}
