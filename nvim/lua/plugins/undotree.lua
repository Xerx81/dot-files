return {
  "mbbill/undotree",
  config = function()
    -- Enable persistent undo
    vim.opt.undofile = true
    local undodir = vim.fn.stdpath("data") .. "/undodir"
    vim.opt.undodir = undodir

    -- Create undodir if it doesn't exist
    if vim.fn.isdirectory(undodir) == 0 then  -- 0 means directory doesn't exist
      vim.fn.mkdir(undodir, "p")
    end

    -- Keymap to toggle undotree
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
  end
}
