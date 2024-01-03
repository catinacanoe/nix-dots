{ pkgs, ... }:
with pkgs.vimPlugins;
{
    plugin = {
        plugin = nvim-cmp;
        type = "lua";
        config = /* lua */ ''
            local cmp = require("cmp")
    
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
                        else
                            cmp.complete()
                        end
                        cmp.open_docs()
                    end, { 'i' }),

                    ['<Down>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            cmp.complete()
                        end
                        cmp.open_docs()
                    end, { 'i' }),

                    ['<S-Up>'] = cmp.mapping(function(fallback)
                        if cmp.visible_docs() then
                            cmp.scroll_docs(-5)
                        else
                            fallback()
                        end
                    end, { 'i', 'c' }),

                    ['<S-Down>'] = cmp.mapping(function(fallback)
                        if cmp.visible_docs() then
                            cmp.scroll_docs(5)
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
                            cmp.close()
                        else
                            fallback()
                        end
                    end, { 'i', 'c' }),
                },

                sources = cmp.config.sources({
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'luasnip' },
                    { name = 'async_path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'buffer' },
                })
            }
        '';
    };

    plugins = [
        cmp-nvim-lsp-signature-help
        cmp_luasnip
        cmp-buffer
        cmp-async-path
        cmp-nvim-lsp
        cmp-nvim-lua
    ];
}
