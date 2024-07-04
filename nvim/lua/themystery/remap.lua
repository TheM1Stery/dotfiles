vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==")
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==")

vim.keymap.set("v", "<A-j>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<A-j>", ":m .-2<CR>==")
vim.keymap.set("n", "<A-k>", ":m .+1<CR>==")


vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set({ "n", "v", "i" }, "<C-z>", "<nop>")
vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


--delete current buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>")

--delete all buffers except current
vim.keymap.set("n", "<leader>bda", "<cmd>:%bd|e#<CR>")

-- macro recording remaps
-- vim.keymap.set("n", "<leader>q", "qq")
-- vim.keymap.set("n", "<leader><leader>", "@q")

-- comments remaps
vim.keymap.set("v", "<C-/>", "gc", { remap = true });
vim.keymap.set("n", "<C-/>", "gcc", { remap = true });


-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)
