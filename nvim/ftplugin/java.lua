local dap_ok, _ = pcall(require, "dap")
local jdtls_ok, jdtls = pcall(require, "jdtls")

if not (dap_ok and jdtls_ok) then
  require("lazy").load({ plugins = { "nvim-dap", "nvim-jdtls" } })
  jdtls = require("jdtls")
end

local shared_config = require('lsp-shared')

local bundles = {}
local debug_bundle_path = os.getenv("JAVA_DEBUG_BUNDLE")
local test_bundle_path = os.getenv("JAVA_TEST_BUNDLE")

if debug_bundle_path then
  local jar = vim.fn.glob(debug_bundle_path .. "/com.microsoft.java.debug.plugin-*.jar", true)
  if jar ~= "" then table.insert(bundles, jar) end
end

if test_bundle_path then
  local test_jars = vim.fn.glob(test_bundle_path .. "/*.jar", true, true)
  local excluded = {
    "com.microsoft.java.test.runner-jar-with-dependencies.jar",
    "jacocoagent.jar",
  }

  for _, jar in ipairs(test_jars) do
    local fname = vim.fn.fnamemodify(jar, ":t")
    if not vim.tbl_contains(excluded, fname) then
      table.insert(bundles, jar)
    end
  end
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

  on_attach = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs({ verbose = true })

    shared_config.on_attach(client, bufnr)
    vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method, { desc = "Test Method", buffer = bufnr })
    vim.keymap.set('n', '<leader>tc', jdtls.test_class, { desc = "Test Class", buffer = bufnr })
  end,
}

jdtls.start_or_attach(config)
