return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.opt.signcolumn = 'yes'

    local shared_config = require('lsp-shared')

    -- A list of servers to set up with the default on_attach and capabilities.
    local servers = {
      'bashls',
      'cssls',
      'dockerls',
      'docker_compose_language_service',
      'nixd',
      'pyright',
      'ruff',
    }

    for _, lsp in ipairs(servers) do
      vim.lsp.config(lsp, {
        on_attach = shared_config.on_attach,
        capabilities = shared_config.capabilities,
      })
      vim.lsp.enable(lsp)
    end

    vim.lsp.config('lua_ls', {
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })
    vim.lsp.enable('lua_ls')

    vim.filetype.add({
      filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
      },
    })

    local cmp = require('cmp')
    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({}),
    })
  end,
}
