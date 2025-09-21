require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Normal mode keybinds
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>gsj", "<cmd> GoTagAdd json <cr>", { desc = "Add json struct tags" })
map("n", "<leader>gsy", "<cmd> GoTagAdd yaml <cr>", { desc = "Add YAML struct tags" })

-- TmuxNavigate
map("n", "<C-h>", "<cmd> TmuxNavigateLeft <cr>", { desc = "window left" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight <cr>", { desc = "window right" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown <cr>", { desc = "window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp <cr>", { desc = "window up" })

-- Visual mode keybinds

-- Insert mode keybinds
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
