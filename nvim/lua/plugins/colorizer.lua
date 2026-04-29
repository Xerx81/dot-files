return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require'colorizer'.setup({
            '*'; -- Highlight colors in all filetypes
            css = { rgb_fn = true; }; -- Enable rgb()/rgba() parsing
            html = { names = true; }; -- Enable color names (like red, blue)
        })
    end
}
