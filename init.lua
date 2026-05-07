local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local opt = vim.opt

-- line numbers
opt.number         = true
opt.relativenumber = true

-- indentation (adjust to taste)
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.expandtab      = true
opt.smartindent    = true

-- search
opt.ignorecase     = true
opt.smartcase      = true
opt.hlsearch       = false
opt.incsearch      = true

-- appearance
opt.termguicolors  = true
opt.signcolumn     = "yes"   -- always show, stops layout shift
opt.scrolloff      = 8       -- keep 8 lines visible above/below cursor
opt.wrap           = false

-- system clipboard
opt.clipboard      = "unnamedplus"

-- splits open naturally
opt.splitright     = true
opt.splitbelow     = true

-- undo file (survives restarts)
opt.undofile       = true

-- Scroll margin
vim.opt.scrolloff = 8

vim.g.mapleader = " "

--keybind
vim.keymap.set("n", "<leader>tv", ":vsp | term<CR>")  -- terminal vertical
vim.keymap.set("n", "<leader>ts", ":sp | term<CR>")   -- terminal horizontal

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

require("lazy").setup({
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  -- bridges mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls", "lua_ls" },  -- add your languages
        automatic_installation = true,
      })
    end
  },

  -- wires up the language servers
  {
    "neovim/nvim-lspconfig",
    config = function()
    vim.lsp.config("pyright", {})
    vim.lsp.config("ts_ls", {})
    vim.lsp.enable({ "pyright", "ts_ls" })
    end
  },

  -- completion engine
  {
    "saghen/blink.cmp",
    version = "*",
    config = function()
      require("blink.cmp").setup({
        keymap = { preset = "default" },
        completion = { documentation = { auto_show = true } },
      })
    end
  },  
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",  -- "hard", "medium", or "soft"
      })
      vim.cmd("colorscheme gruvbox")
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end
  },

  -- auto close and rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
})
