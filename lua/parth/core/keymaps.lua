local map = require("parth.helpers.keys").map

-- move text up or down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "J", "mzJ`z")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- delete without copying
map({ "n", "v" }, "<leader>d", [["_d]])

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

map("n", "<C-S-k>", "<cmd>cnext<CR>zz")
map("n", "<C-S-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>

-- replacing text
map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>rs", [["hy:%s/<C-r>h//gc<left><left><left>]])

-- give execute permission
map("n", "<leader>x", "<cmd>!chmod +x %<CR>")

map("n", "<leader><leader>", function()
  vim.cmd("so")
end)

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

map("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Go to next buffer" })
map("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Go to previous buffer" })
map("n", "<leader>bx", "<cmd>bd<CR>", { desc = "Delete current buffer" })

-- remove C-j and C-k remaps
-- map("n", "<C-J>", "")
-- map("n", "<C-K>", "")
