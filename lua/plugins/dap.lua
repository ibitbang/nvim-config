return {
  -- DAP core and UI
  { "mfussenegger/nvim-dap" },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- optional, but nice to have the UI ready
      require("dapui").setup()
    end,
  },

  { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },

  -- Cortex-Debug adapter integration
  {
    "jedrzejboczar/nvim-dap-cortex-debug",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- 0) Helper: source an env file (zsh) and import all vars into vim.env
      local function source_env_file(file, opts)
        opts = opts or {}
        local shell = opts.shell or "zsh" -- your script uses zsh
        local cwd = opts.cwd or vim.fn.getcwd() -- project root (so relative paths in the script work)

        -- Use NUL-separated output to safely parse values containing spaces/newlines
        local cmd = string.format([[%s -lc 'set -a; cd %q; source %q >/dev/null 2>&1; env -0']], shell, cwd, file)
        local out = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
          vim.notify("[dap env] Failed to source: " .. file .. "\n" .. out, vim.log.levels.ERROR)
          return
        end
        for entry in out:gmatch("([^%z]+)%z") do
          local k, v = entry:match("^([%w_]+)=(.*)$")
          if k and v then
            vim.env[k] = v
          end
        end
      end

      -- 1) Import your toolchain environment *before* adapter setup
      --    Adjust the path below to wherever your setup_env.sh lives.
      --    If the script sits in the project, keep cwd = current project root.
      local setup_script = vim.fn.expand("~/setup_env.sh") -- e.g. "~/.config/nvim/setup_env.sh" or project path
      if vim.loop.fs_stat(setup_script) then
        source_env_file(setup_script, { shell = "zsh", cwd = vim.fn.getcwd() })
      else
        -- Optional: auto-detect in project root (walk up to find setup_env.sh)
        local function find_up(name, start)
          local dir = vim.fn.fnamemodify(start or vim.fn.getcwd(), ":p")
          while dir and #dir > 1 do
            local candidate = dir .. "/" .. name
            if vim.loop.fs_stat(candidate) then
              return candidate
            end
            dir = vim.fn.fnamemodify(dir, ":h")
          end
        end
        local proj_script = find_up("setup_env.sh")
        if proj_script then
          source_env_file(proj_script, { shell = "zsh", cwd = vim.fn.fnamemodify(proj_script, ":h") })
        else
          vim.notify("[dap env] setup_env.sh not found; continuing without it", vim.log.levels.WARN)
        end
      end

      require("dap-cortex-debug").setup({
        -- leave this out if you don't use RTT; set to true if you do
        dapui_rtt = true,
        -- extension_path can usually be auto-detected (e.g., via Mason).
        -- If detection fails, uncomment and set it explicitly:
        -- extension_path = vim.fn.stdpath("data") .. "/mason/packages/cortex-debug/extension",
      })

      -- 3. Define DAP configurations for C/C++ (Zephyr projects are in C)
      local dap = require("dap")
      dap.configurations.c = {
        {
          name = "Debug nRF5340 (Zephyr RTOS)",
          type = "cortex-debug",
          request = "launch",
          servertype = "jlink", -- Use J-Link GDB server:contentReference[oaicite:30]{index=30}
          device = "nRF5340_xxAA_APP", -- Target device (Application core)
          interface = "swd",
          runToEntryPoint = "main",
          gdbPath = "arm-zephyr-eabi-gdb",
          toolchainPrefix = "arm-zephyr-eabi",
          speed = "20000",
          cwd = "/Users/adityagandhi/workspace/Aruba",
          executable = "/Users/adityagandhi/workspace/Aruba/application//build_debug_noramfs/application/zephyr/zephyr.elf",
          svdFile = "/Users/adityagandhi/workspace/Aruba/external/modules/hal/nordic/nrfx/mdk/nrf5340_application.svd",
          serverArgs = { "-rtos", "/Users/adityagandhi/workspace/Tools/jlink-zephyr/build/libzephyr_rtos.so" },
          showDevDebugOutput = false, -- set true to see adapter logs for debugging issues,
          runToEntryPoint = "main",
          preLaunchCommands = { "monitor reset halt", "load", "monitor reset halt" },

        },
      }
      dap.configurations.cpp = dap.configurations.c -- If using C++, use the same config
    end,
  },
}
