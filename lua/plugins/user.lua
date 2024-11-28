local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
if BinaryFormat == "dll" then
    function os.name()
        return "Windows"
    end
elseif BinaryFormat == "so" then
  if os.getenv("WSL_INTEROP") or os.getenv("WSL_DISTRO_NAME") then
    function os.name()
      return "WSL"
    end
  else
    function os.name()
        return "Linux"
    end
  end
elseif BinaryFormat == "dylib" then
    function os.name()
        return "MacOS"
    end
end
BinaryFormat = nil

local remote_nvim_available = os.name() != "WSL"

return {
---@type LazySpec

  {
    {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
    }
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_backgrounf= true,
      integrations = {
        notify = true,
        aerial = true,
        alpha= true,
        fidget = true,
        fzf = true,
        noice = true,
        nvimtree = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
     notification = {
        window = {
            winblend = 0,
        },
      },
    },
  },
  {
    "sheerun/vim-polyglot",
    lazy = false,
  },
    {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function ()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      if os.name() == "MacOS" then
        LIBLLDB_PATH  = extension_path.. "lldb/lib/liblldb.dylib"
        end
	    if os.name() == "Linux" then
	      LIBLLDB_PATH = extension_path .. "lldb/lib/liblldb.so"
	    end
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, LIBLLDB_PATH),
        },
      }
    end
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
			local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
       dapui.close()
      end
		end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
			require("dapui").setup()
		end,
  },

  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = true,
    enabled = remote_nvim_available
  }
}
