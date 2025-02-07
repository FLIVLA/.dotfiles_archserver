return {
    { "hrsh7th/cmp-nvim-lsp" },
    { "onsails/lspkind.nvim" },
    { "roobert/tailwindcss-colorizer-cmp.nvim" },
    { "micangl/cmp-vimtex" },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "andymass/vim-matchup",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Load Catppuccin Macchiato palette and set up colors
            local catppuccin = require("catppuccin.palettes").get_palette("macchiato")
            local crust = catppuccin.crust


            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = 'orgmode' }
                }, {
                    { name = "buffer" },
                }),

                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 60,
                        ellipsis_char = "...",
                        menu = {
                            -- buffer = "[Buffer]",
                            -- nvim_lsp = "[LSP]",
                            -- nvim_lua = "[Lua]",
                            -- luasnip = "[LuaSnip]",
                            -- latex_symbols = "[Latex]",
                            buffer = "",
                            nvim_lsp = "",
                            nvim_lua = "",
                            luasnip = "",
                            latex_symbols = "",

                        },
                        before = function(entry, vim_item)
                            vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                            return vim_item
                        end,
                    }),
                },
            })

            vim.api.nvim_set_hl(0, "CmpPmenu", { bg = crust, fg = catppuccin.text })
            vim.api.nvim_set_hl(0, "CmpPmenuSel", { bg = catppuccin.surface1, fg = catppuccin.text })
            vim.api.nvim_set_hl(0, "CmpPmenuBorder", { bg = crust, fg = catppuccin.crust })
            vim.api.nvim_set_hl(0, "CmpDoc", { bg = crust, fg = catppuccin.text })
            vim.api.nvim_set_hl(0, "CmpDocBorder", { bg = crust, fg = catppuccin.crust })
        end,
    },
}
