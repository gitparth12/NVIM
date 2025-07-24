local opts = {
  shiftwidth = 2,
  tabstop = 2,
  expandtab = true,
  wrap = false,
  termguicolors = true,
  number = true,
  relativenumber = true,
  swapfile = false,
  backup = false,
  undodir = os.getenv("HOME") .. "/.vim.undodir",
  undofile = true,
  incsearch = true,
  hlsearch = true,
  scrolloff = 8,
  signcolumn = "yes",
  -- colorcolumn = 80,
  updatetime = 250,
  pumheight = 10,
  mousemoveevent = true,
}

-- Set options from table
for opt, val in pairs(opts) do
  vim.o[opt] = val
end

-- Set other options
local colorscheme = require("parth.helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)
-- Set command bar color
vim.cmd.highlight("MsgArea guibg=#16161e")
