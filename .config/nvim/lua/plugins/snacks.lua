return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- show dotfiles like .env
          ignored = true, -- show files ignored by .gitignore
          exclude = { ".git", "node_modules" }, -- optional
        },
      },
    },
  },
}
