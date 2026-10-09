vim.g.python3_host_prog = vim.fn.trim(vim.fn.system({ "uv", "run", "--quiet", "--project", vim.fn.stdpath("config") .. "/python-provider", "--exact", "python", "-c", "import sys; print(sys.executable)" }))
require("config.lazy")
