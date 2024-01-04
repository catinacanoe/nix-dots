{ plugins, ... }:
let
    config = /* lua */ ''{
        "hrsh7th/nvim-cmp",

        lazy = true,
        event = {
            "InsertEnter",
        },

        config = function(_, _)
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },

                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                mapping = {
                    ['<Up>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            cmp.complete()
                        end
                        cmp.open_docs()
                    end, { 'i', 's' }),

                    ['<Down>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            cmp.complete()
                        end
                        cmp.open_docs()
                    end, { 'i', 's' }),

                    ['<S-Up>'] = cmp.mapping(function(fallback)
                        if cmp.visible_docs() then
                            cmp.scroll_docs(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 'c' }),

                    ['<S-Down>'] = cmp.mapping(function(fallback)
                        if cmp.visible_docs() then
                            cmp.scroll_docs(1)
                        else
                            fallback()
                        end
                    end, { 'i', 'c' }),

                    ['<Left>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end, { 'i', 'c' }),

                    ['<Right>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm()
                        else
                            fallback()
                        end
                    end, { 'i', 'c' }),
                },

                sources = cmp.config.sources({
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'neorg' },
                    { name = 'luasnip' },
                    { name = 'async_path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
                    { name = 'dotenv' },
                    { name = 'fonts' },
                    -- { name = 'dap' },
                })
            }
        end,

        dependencies = {
            "L3MON4D3/LuaSnip",
            "FelipeLema/cmp-async-path",
            "amarakon/nvim-cmp-fonts",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            "sergioribera/cmp-dotenv",
            "nvim-neorg/neorg",
            -- "rcarriga/cmp-dap",
        }
    }'';
in
{
    plugin."${plugins}/cmp.lua".text= "return {${config}}";
}
