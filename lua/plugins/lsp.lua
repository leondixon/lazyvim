return {
  "neovim/nvim-lspconfig",
  opts = function()
    -- Create an Auto Command that runs whenever an LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        -- 1. If ESLint just attached, disable vtsls formatting
        if client.name == "eslint" then
          local vtsls = vim.lsp.get_clients({ bufnr = args.buf, name = "vtsls" })[1]
          if vtsls then
            vtsls.server_capabilities.documentFormattingProvider = true
          end
        end

        -- 2. If vtsls just attached, check if ESLint is already there
        if client.name == "vtsls" then
          local eslint = vim.lsp.get_clients({ bufnr = args.buf, name = "eslint" })[1]
          if eslint then
            client.server_capabilities.documentFormattingProvider = true
          end
        end
      end,
    })
  end,
}
