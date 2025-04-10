-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_background = true,
      default_integrations = true,
      integrations = {
        aerial = true,
        fidget = true,
        mason = true,
        neotree = true,
        noice = true,
        notify = true,
        nvim_surround = true,
        lsp_trouble = true,
        which_key = true,
      },
    },
  },
  -- -- lazy.nvim
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     lsp = {
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --     -- you can enable a preset for easier configuration
  --     presets = {
  --       bottom_search = true, -- use a classic bottom cmdline for search
  --       command_palette = true, -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = false, -- add a border to hover docs and signature help
  --     },
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   },
  -- },
  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = {
      ring = { storage = "sqlite" },
    },
    keys = {
      { "<leader>p", "<cmd>yankyringhistory<cr>", mode = { "n", "x" }, desc = "open yank history" },
      { "y", "<plug>(yankyyank)", mode = { "n", "x" }, desc = "yank text" },
      { "p", "<plug>(yankyputafter)", mode = { "n", "x" }, desc = "put yanked text after cursor" },
      { "p", "<plug>(yankyputbefore)", mode = { "n", "x" }, desc = "put yanked text before cursor" },
      { "gp", "<plug>(yankygputafter)", mode = { "n", "x" }, desc = "put yanked text after selection" },
      { "gp", "<plug>(yankygputbefore)", mode = { "n", "x" }, desc = "put yanked text before selection" },
      { "<c-p>", "<plug>(yankypreviousentry)", desc = "select previous entry through yank history" },
      { "<c-n>", "<plug>(yankynextentry)", desc = "select next entry through yank history" },
      { "]p", "<plug>(yankyputindentafterlinewise)", desc = "put indented after cursor (linewise)" },
      { "[p", "<plug>(yankyputindentbeforelinewise)", desc = "put indented before cursor (linewise)" },
      { "]p", "<plug>(yankyputindentafterlinewise)", desc = "put indented after cursor (linewise)" },
      { "[p", "<plug>(yankyputindentbeforelinewise)", desc = "put indented before cursor (linewise)" },
      { ">p", "<plug>(yankyputindentaftershiftright)", desc = "put and indent right" },
      { "<p", "<plug>(yankyputindentaftershiftleft)", desc = "put and indent left" },
      { ">p", "<plug>(yankyputindentbeforeshiftright)", desc = "put before and indent right" },
      { "<p", "<plug>(yankyputindentbeforeshiftleft)", desc = "put before and indent left" },
      { "=p", "<plug>(yankyputafterfilter)", desc = "put after applying a filter" },
      { "=p", "<plug>(yankyputbeforefilter)", desc = "put before applying a filter" },
    },
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
