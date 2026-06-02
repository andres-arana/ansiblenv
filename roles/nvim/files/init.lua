--------------------------------------------------------------------------------
-- Standard vim globals
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.localleader = " "
--------------------------------------------------------------------------------
-- Standard vim options
--------------------------------------------------------------------------------
-- Enable experimental ui2
require("vim._core.ui2").enable({})
-- Disable completion messages to prevent autocomplete from spamming messages
vim.opt.shortmess:append("c")
-- Set up completion options
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
-- Show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Display whitespace characters
vim.opt.list = true
vim.opt.listchars = "tab: ,trail:󱁐,nbsp:"
-- Ignore cases in searches, but do not if the search term contains capital
-- letters
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Wrap using complete words
vim.opt.linebreak = true
-- Make sure wrapped text gets properly indented
vim.opt.breakindent = true
-- Indent settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.expandtab = true
-- Folding
vim.opt.foldmethod = "syntax"
-- Allow visual block mode on empty chars
vim.opt.virtualedit = "block"
-- Enable spell checing
vim.opt.spelllang = "en_us,es_mx"
-- Let terminal handle cursor shape
vim.opt.guicursor = ""
-- Let context lines around jumps
vim.opt.scrolloff = 8
--------------------------------------------------------------------------------
-- Standard autocommands
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function() vim.hl.on_yank() end,
})
--------------------------------------------------------------------------------
-- Standard mappings
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>pu", function() vim.pack.update(nil) end)
vim.keymap.set("n", "<leader>ps", function() vim.pack.update(nil, { offline = true }) end)
vim.keymap.set("n", "<leader>ce", function() vim.cmd.edit("$MYVIMRC") end)
vim.keymap.set("n", "<leader>ct", function() vim.cmd.tabedit("$MYVIMRC") end)
vim.keymap.set("n", "<leader>cr", ":restart<cr>")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")
--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
-- Paired mappings
vim.pack.add({
  "https://github.com/tpope/vim-unimpaired",
})

-- Mark navigation
vim.pack.add({
  "https://github.com/chentoast/marks.nvim",
})
require("marks").setup()

-- Filesystem browser
vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/stevearc/oil.nvim",
})
require("mini.icons").setup()
require("oil").setup({
  view_options = {
    show_hidden = true,
  }
})
vim.keymap.set("n", "-", "<cmd>Oil<cr>")


-- Fuzzy finder
vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})
local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>ff", function() fzf.files() end)
vim.keymap.set("n", "<leader>fg", function() fzf.live_grep() end)

-- Text objects
vim.pack.add({
  "https://github.com/nvim-mini/mini.ai",
})
require("mini.ai").setup()

-- Surround text
vim.pack.add({
  "https://github.com/nvim-mini/mini.surround",
})
require("mini.surround").setup()

-- Align columns
vim.pack.add({
  "https://github.com/nvim-mini/mini.align"
})
require("mini.align").setup()

-- Highlight and remove trailing whitespace
vim.pack.add({
  "https://github.com/nvim-mini/mini.trailspace"
})
local MiniTrailspace = require("mini.trailspace")
MiniTrailspace.setup()
vim.keymap.set("n", "<leader>tw", function()
  MiniTrailspace.trim()
  MiniTrailspace.trim_last_lines()
end)

-- Colorscheme
vim.pack.add({
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/sainnhe/gruvbox-material" },
})
vim.cmd.colorscheme("gruvbox-material")

-- Statusline
vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim"
})
require("lualine").setup()

-- Indent guides
vim.pack.add({
  "https://github.com/lukas-reineke/indent-blankline.nvim",
})
require("ibl").setup()

-- Notifications window
vim.pack.add({
  "https://github.com/nvim-mini/mini.notify",
})
require("mini.notify").setup({
  lsp_progress = {
    enable = false,
  }
})

-- Syntax parsers
vim.pack.add({
  "https://github.com/romus204/tree-sitter-manager.nvim"
})
require("tree-sitter-manager").setup({
  auto_install = true,
})

-- Rainbow delimiters
vim.pack.add({
  "https://github.com/hiphish/rainbow-delimiters.nvim",
})
require("rainbow-delimiters.setup").setup()

-- LSP
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",

})
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright" }
})

-- Auto completions
vim.pack.add({
  "https://github.com/nvim-mini/mini.completion",
})
require("mini.completion").setup()

--------------------------------------------------------------------------------
-- LSP settings
--------------------------------------------------------------------------------
-- Display errors on virtua lines
vim.diagnostic.config({
  virtual_lines = true,
})

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("mini.completion").get_lsp_capabilities()
local capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp_capabilities)
vim.lsp.config("*", { capabilities = capabilities })
