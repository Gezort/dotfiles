local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  disable_filetypes = { "TelescopePrompt", "NvimTree" },
  fast_wrap = {},
})
