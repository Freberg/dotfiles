local dap_ok, _ = pcall(require, "dap")
local jdtls_ok, jdtls = pcall(require, "jdtls")

if not (dap_ok and jdtls_ok) then
  require("lazy").load({ plugins = { "nvim-dap", "nvim-jdtls" } })
  jdtls = require("jdtls")
end

local shared_config = require('lsp-shared')

local debug_bundle = vim.fn.glob(
  "/nix/store/*vscode-extension-vscjava-vscode-java-debug*/share/vscode/extensions/*/server/com.microsoft.java.debug.plugin-*.jar",
  true
)

local bundles = {}
if debug_bundle ~= "" then
  table.insert(bundles, debug_bundle)
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name

local config = {
  cmd = { 'jdtls', '-data', workspace_dir },
  root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew' }),
  capabilities = shared_config.capabilities,

  init_options = {
    bundles = bundles
  },
}

jdtls.start_or_attach(config)
