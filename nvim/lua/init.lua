local dap = require('dap');
dap.set_log_level('TRACE');
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  name = "node-debug",
  port = "45635",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"~/dev/vscode-js-debug-1.91.0/src/dapDebugServer.ts", "${port}"},
  }
}

require("dap").configurations.typescript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = "Launch file",
    runtimeExecutable = "node",
    protocol = "inspector",
    runtimeArgs = {
      "run",
      "--loader",
      "ts-node/esm",
    },
    sourceMaps = false,
    program = "${file}",
    cwd = "${workspaceFolder}",
    attachSimplePort = 9229,
  },
}
