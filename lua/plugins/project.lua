return {
  "ahmedkhalf/project.nvim",
  -- can't use 'opts' because module has non standard name 'project_nvim'
  config = function()
    require("project_nvim").setup({
      patterns = {
        ".git",
        "CMakeLists.txt",
        ".clangd",
        ".githubg",
      },
      -- detection_methods = { "lsp", "pattern" },
      detection_methods = { "pattern" },
      exclude_dirs = { "build", ".cache" },
    })
  end,
}
