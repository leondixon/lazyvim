return {
  "stevearc/conform.nvim",
  opts = {
    -- Ensure you are using eslint_d (or eslint) for formatting
    formatters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
    },
    -- Dynamic format-on-save logic
    format_on_save = function(bufnr)
      -- Check if the 'eslint' LSP client is active for this buffer
      -- (Use 'vim.lsp.get_active_clients' if on neovim < 0.10)
      local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })

      if #clients > 0 then
        -- ESLint is active: format with eslint_d, but strictly NO fallback to vtsls
        return { timeout_ms = 3000, lsp_fallback = false }
      else
        -- ESLint is NOT active: allow fallback to vtsls (good for non-eslint projects)
        return { timeout_ms = 3000, lsp_fallback = true }
      end
    end,
  },
}
