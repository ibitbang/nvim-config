return {
  {
    'mrcjkb/rustaceanvim',
    -- To avoid being surprised by breaking changes,
    -- I recommend you set a version range
    version = '^9',
    -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
    -- No need for lazy.nvim to lazy-load it.
    lazy = false,
  },
  -- rustaceanvim runs `rust-analyzer` from PATH; Mason's bin comes first there, so every Mac gets the same one
  -- (rustup's ~/.cargo/bin/rust-analyzer is only a proxy that fails unless the rustup component is installed).
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'rust-analyzer' } },
  },
}
