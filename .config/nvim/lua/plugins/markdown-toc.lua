return {
  "hedyhli/markdown-toc.nvim",
  ft = "markdown", -- Load only for Markdown files
  cmd = { "Mtoc" }, -- Lazy-load on command
  opts = {
    auto_update = true, -- Auto-update TOC on save
    fences = {
      enabled = true,
      start_text = "mtoc-start",
      end_text = "mtoc-end",
    },
  },
}
