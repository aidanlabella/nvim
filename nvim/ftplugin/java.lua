local mod_root = '~/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository'

local config = {
  -- The command that starts the language server
  cmd = {
    'init_jdt',
    -- See the init_jdt file for more config options
  },
    capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true
            }
      }
    }
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
}

require('jdtls').start_or_attach(config)
