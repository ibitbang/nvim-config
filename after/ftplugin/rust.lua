-- Rust buffers: rustaceanvim's grouped code actions and hover actions instead of LazyVim's plain ones.
-- Set through Snacks.keymap with an LSP filter, the way LazyVim sets its K / <leader>ca: Snacks re-applies LSP keys
-- whenever rust-analyzer attaches or registers capabilities, and the newest keymap wins (a plain buffer map is overwritten).
-- <leader>ca, not <leader>a: <leader>a is the Claude Code (ai.claudecode) group.
if not _G.Snacks then
  return
end
Snacks.keymap.set("n", "<leader>ca", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
end, { lsp = { name = "rust-analyzer" }, silent = true, desc = "Code Action (Rust)" })
Snacks.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { lsp = { name = "rust-analyzer" }, silent = true, desc = "Hover Actions (Rust)" })
