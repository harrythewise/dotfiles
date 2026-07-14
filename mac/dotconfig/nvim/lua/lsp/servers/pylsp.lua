return {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
    },
    -- configurationSources = { "flake8" },
    settings = {
        pylsp = {
            plugins = {
                flake8 = {
                    enabled = false,
                    maxLineLength = 999,
                    maxComplexity = 15
                },
                pycodestyle = {
                    enabled = false,
                    maxLineLength = 999
                },
                pyflakes = {
                    enabled = false
                },
                mccabe = {
                    enabled = false,
                },
                pylint = {
                    enabled = false
                },
                rope_autoimport = {
                    enabled = false
                },
                rope_completion = {
                    enabled = false
                },
                ruff = {
                    enabled = true,
                },
                jedi = {
                    environment = vim.fn.getcwd() .. '/.venv/bin/python',
                },
                jedi_completion = {
                    enabled = true,
                    include_params = true,
                    include_class_objects = true,
                    include_function_objects = true,
                    fuzzy = false,
                    eager = false,
                    resolve_at_most = 25,
                    cache_for = { "pandas", "numpy", "tensorflow", "matplotlib", "cv2", "django" },
                },
            },

        }
    }
}
