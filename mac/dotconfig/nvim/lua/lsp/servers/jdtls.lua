local java_home = vim.fn.expand("~/.sdkman/candidates/java/21.0.7-tem/")

local root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]) or vim.fn.getcwd()

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local data_dir = vim.fn.expand("~/.cache/nvim/jdtls/projects/") .. project_name

local formatter_path = root_dir .. "/.nvim/java/formatter.xml"
local java_settings_prefs_path = vim.fn.expand("~/Projects/Templates/settings.prefs")

local function setup_bundles()
    local bundles = {
        vim.fn.glob(
            "~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
            1
        ),
    }

    local java_test_bundles =
        vim.split(vim.fn.glob("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\n")

    local excluded = {
        "com.microsoft.java.test.runner-jar-with-dependencies.jar",
        "jacocoagent.jar",
    }

    for _, java_test_jar in ipairs(java_test_bundles) do
        local fname = vim.fn.fnamemodify(java_test_jar, ":t")
        if not vim.tbl_contains(excluded, fname) then
            table.insert(bundles, java_test_jar)
        end
    end
    return bundles
end

return {
    cmd = {
        java_home .. "bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Dorg.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning",
        "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. vim.fn.expand("~/Projects/Tools/Neovim/jdtls/plugins/lombok.jar"),
        "-jar",
        vim.fn.expand("~/Projects/Tools/Neovim/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar"),
        "-configuration",
        vim.fn.expand("~/Projects/Tools/Neovim/jdtls/config_mac_arm/"),
        "-data",
        data_dir,
    },

    filetypes = { "java" },
    root_dir = root_dir,
    on_attach = function(client, bufrn)
        if vim.fn.filereadable(formatter_path) ~= 1 then
            vim.notify("ERROR: Java formatter.xml not found at: " .. formatter_path)
        end
    end,

    settings = {
        java = {
            settings = {
                url = java_settings_prefs_path,
            },

            signatureHelp = {
                enabled = true,
            },

            configuration = {
                runtimes = {},
            },

            saveActions = {
                organizeImports = vim.fn.filereadable(formatter_path) == 1,
            },

            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },

            import = {
                maven = {
                    enabled = false,
                },
                exclusions = {
                    "**/node_modules/**",
                    "**/.metadata/**",
                    "**/archetype-resources/**",
                    "**/META-INF/maven/**",
                    "/**/test/**",
                },
            },

            format = {
                enabled = vim.fn.filereadable(formatter_path) == 1,
                settings = {
                    url = formatter_path,
                    profile = "JavaFormatter",
                },
            },

            cleanup = {
                addOverride = "@Override",
                addDeprecated = "@Deprecated",
                addFinalModifier = "final",
            },
        },
    },

    init_options = {
        bundles = setup_bundles(),
        extendedClientCapabilities = {
            classFileContentsSupport = true,
            reloadBundles = true,
        },
    },
}
