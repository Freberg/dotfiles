return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://localhost:11434",
              },
              schema = {
                model = {
                  default = "gpt-oss:20b"
                }
              }
            })
          end
        },
        acp = {
          opencode = function()
            return require("codecompanion.adapters").extend("opencode", {
              commands = {
                -- The default uses the opencode/config.json value
                default = {
                  "opencode",
                  "acp",
                }
              }
            })
          end
        }
      },
      interactions = {
        chat = {
          adapter = "opencode",
        },
        inline = {
          adapter = "ollama",
        },
      }
    },
    keys = {
    {
      "<leader>at",
      function()
        require("codecompanion").toggle({ window_opts = { layout = "float", width = 0.9 } })
      end,
      mode = { "n", "x" },
      desc = "Toggle codecompanion chat",
    },
    {
      "<leader>aa",
      ":CodeCompanionActions<CR>",
      mode = { "n", "x" },
      desc = "Open codecompanion actions",
    },
    {
      "<leader>as",
      ":CodeCompanion<CR>",
      mode = { "n", "x" },
      desc = "Ask codecompanion",
    },
  }
}
