local mod_root = '~/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository'

local config = {
  -- The command that starts the language server
  cmd = {
    '/usr/bin/java',
	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
	'-Dosgi.bundles.defaultStartLevel=4',
	'-Declipse.product=org.eclipse.jdt.ls.core.product',
	'-Dlog.level=ALL',
	'-noverify',
	'-Xmx1G',
	'-jar', '/Users/aidan/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
	'-configuration', '/Users/aidan/dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac',
	'--add-modules=ALL-SYSTEM',
	'--add-opens java.base/java.util=ALL-UNNAMED',
	'--add-opens java.base/java.lang=ALL-UNNAMED'
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
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}

require('jdtls').start_or_attach(config)
