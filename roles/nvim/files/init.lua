--------------------------------------------------------------------------------
-- Standard vim globals
--------------------------------------------------------------------------------
do
  vim.g.mapleader = " "
  vim.g.localleader = " "
end
--------------------------------------------------------------------------------
-- Standard vim options
--------------------------------------------------------------------------------
do
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
  vim.opt.foldenable = false
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  -- Allow visual block mode on empty chars
  vim.opt.virtualedit = "block"

  -- Enable spell checing
  vim.opt.spelllang = "en_us,es_mx"

  -- Let terminal handle cursor shape
  vim.opt.guicursor = ""

  -- Let context lines around jumps
  vim.opt.scrolloff = 8
end
--------------------------------------------------------------------------------
-- Standard autocommands
--------------------------------------------------------------------------------
do
  -- Hightlight after yanking for feedback
  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function() vim.hl.on_yank() end,
  })
end
--------------------------------------------------------------------------------
-- Standard mappings
--------------------------------------------------------------------------------
do
  vim.keymap.set("n", "<leader>pu", function() vim.pack.update(nil) end)
  vim.keymap.set("n", "<leader>ps", function() vim.pack.update(nil, { offline = true }) end)
  vim.keymap.set("n", "<leader>ce", function() vim.cmd.edit("$MYVIMRC") end)
  vim.keymap.set("n", "<leader>ct", function() vim.cmd.tabedit("$MYVIMRC") end)
  vim.keymap.set("n", "<leader>cr", ":restart<cr>")
  vim.keymap.set({"n", "v"}, "gf", ":edit <cfile><cr>")
  vim.keymap.set("t", "<leader><esc>", "<C-\\><C-n>")
end
--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
do
  -- Icons used by many other plugins
  vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-mini/mini.icons",
  })
  require("mini.icons").setup()

  -- Paired mappings
  vim.pack.add({
    "https://github.com/tpope/vim-unimpaired",
  })

  -- Mark navigatio
  vim.pack.add({
    "https://github.com/chentoast/marks.nvim",
  })
  require("marks").setup()

  -- Filesystem browser
  vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
  })
  require("oil").setup({
    view_options = {
      show_hidden = true,
    },
  })
  vim.keymap.set("n", "-", "<cmd>Oil<cr>")

  -- Fuzzy finder
  vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
  })
  local fzf = require("fzf-lua")
  vim.keymap.set("n", "<leader>ff", function() fzf.files() end)
  vim.keymap.set("n", "<leader>fg", function() fzf.live_grep() end)
  vim.keymap.set("n", "<leader>fla", function() fzf.lsp_code_actions() end)
  vim.keymap.set("n", "<leader>fc", function() fzf.builtin() end)

  -- Text objects
  vim.pack.add({
    "https://github.com/nvim-mini/mini.ai",
  })
  require("mini.ai").setup({
    custom_textobjects = {
      -- Whole buffer
      g = function()
        local from = { line = 1, col = 1 }
        local to = {
          line = vim.fn.line('$'),
          col = math.max(vim.fn.getline('$'):len(), 1)
        }
        return { from = from, to = to }
      end
    }
  })

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

  -- Move text around
  vim.pack.add({ 'https://github.com/nvim-mini/mini.move' })
  require("mini.move").setup()

  -- Spilt and join argument lists
  vim.pack.add({ 'https://github.com/nvim-mini/mini.splitjoin' })
  require("mini.splitjoin").setup()

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
    { src = "https://github.com/sainnhe/gruvbox-material" },
  })
  vim.cmd.colorscheme("gruvbox-material")

  -- Statusline
  vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim"
  })
  require("lualine").setup({
    extensions = { "oil" },
  })

  -- Indent guides
  vim.pack.add({
    "https://github.com/nvim-mini/mini.indentscope"
  })
  require("mini.indentscope").setup()

  -- Notifications window
  vim.pack.add({
    "https://github.com/j-hui/fidget.nvim",
  })
  require("fidget").setup({ })

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

  -- Claude code integration
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://www.github.com/olimorris/codecompanion.nvim",
  })
  local CodeCompanion = require("codecompanion")
  CodeCompanion.setup({
    display = {
      cli = {
        window = {
          width = 0.3
        },
      },
    },
    interactions = {
      cli = {
        agent = "claude_code",
        agents = {
          claude_code = {
            cmd = "claude",
            args = {},
            description = "Claude Code CLI",
            provider = "terminal",
          },
        },
      },
    },
  })
  vim.keymap.set({ "n", "v"}, "<leader>cc", function ()
    return CodeCompanion.cli()
  end)
  vim.keymap.set({"n", "v"}, "<leader>cp", function()
    return CodeCompanion.cli({ prompt = true })
  end)
  vim.keymap.set({ "n", "v" }, "<leader>ca", function()
    return CodeCompanion.cli("#{this}", { focus = false })
  end, { desc = "Add context to the CLI agent" })

  -- LSP
  vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",

  })
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "basedpyright", "ruff",
      "ts_ls",
      "bashls",
      "terraformls",
    }
  })

  -- Snippets
  vim.pack.add({
    "https://github.com/nvim-mini/mini.snippets",
    "https://github.com/rafamadriz/friendly-snippets",
  })
  local snippets = require("mini.snippets")
  snippets.setup({
    snippets = {
      snippets.gen_loader.from_lang(),
    },
  })

  -- Auto completions
  vim.pack.add({
    {
      src = "https://github.com/saghen/blink.cmp",
      version = "v1",
    }
  })
  require("blink.cmp").setup({
    keymap = {
      preset = "default",
    },
    completion = {
      documentation = {
        auto_show = true,
      },
    },
    fuzzy = { implementation = "lua" },
    snippets = { preset = "mini_snippets" },
  })
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  vim.lsp.config("*", { capabilities = capabilities })
end

-- Markdown rendering
vim.pack.add({
  "https://github.com/meanderingprogrammer/render-markdown.nvim"
})
require("render-markdown").setup({

})
--------------------------------------------------------------------------------
-- LSP settings
--------------------------------------------------------------------------------
do
  -- Set icons for diagnostics
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.INFO]  = "",
        [vim.diagnostic.severity.HINT]  = "  ",
      },
    },
  })
  -- Display errors on virtua lines
  vim.diagnostic.config({
    virtual_text = true,
  })
  -- Toggle diagnostic details
  vim.keymap.set("n", "<leader>dv", function ()
    vim.diagnostic.config({
      virtual_text = not vim.diagnostic.config().virtual_text
    })
  end)

  -- Specific lsp server settings
  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        analysis = {
          diagnosticSeverityOverrides =
          {
            reportExplicitAny = false,
            reportAny = false,
            reportUnknownVariableType = false,
            reportUnknownMemberType = false,
            reportUnknownParameterType = false,
            reportUnknownArgumentType = false,
            reportUnknownLambdaType = false,
            reportMissingTypeArgument = false,
          }
        },
      },
    },
  })

  vim.lsp.config("bigquery-language-server", {
    cmd = { "uv", "run", "bigquery-language-server" },
    filetypes = { "sql" },
    root_markers = { "pyproject.toml" },
  })
  vim.lsp.enable("bigquery-language-server")
end
