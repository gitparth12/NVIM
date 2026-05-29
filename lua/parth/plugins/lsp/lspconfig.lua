-- TODO: setup telescope ui for lsp diagnostics
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    { "SmiteshP/nvim-navic" },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = require("parth.helpers.keys").map

    local border = {
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = "󰌵 ",
        },
      },
      underline = true,
      virtual_text = false,
      virtual_lines = false,
      update_in_insert = true,
      float = {
        -- UI.
        ---@diagnostic disable-next-line: assign-type-mismatch
        header = false,
        border = "rounded",
        focusable = true,
      },
    })

    -- Check for "lsp: off" or "lsp: disable" in the first 5 lines of the buffer
    local function has_lsp_disable_comment(bufnr)
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 5, false) -- check first 5 lines
      for _, line in ipairs(lines) do
        if line:match("lsp%s*:%s*off") or line:match("lsp%s*:%s*disable") then
          return true
        end
      end
      return false
    end
    -- Check for `.no-lsp` marker in the current or parent directories
    local function has_no_lsp_marker(bufnr)
      local path = vim.api.nvim_buf_get_name(bufnr)
      local dir = vim.fn.fnamemodify(path, ":p:h")

      while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/.no-lsp") == 1 then
          return true
        end
        dir = vim.fn.fnamemodify(dir, ":h")
      end
      return false
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local navic = require("nvim-navic")
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- Check for lsp:off comment
        if (has_lsp_disable_comment(ev.buf) or has_no_lsp_marker(ev.buf)) and client ~= nil then
          vim.schedule(function()
            client.stop()
          end)
          return
        end

        -- set keybinds
        opts.desc = "Show LSP references"
        map("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        map("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        map("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        map("n", "<leader>fD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        map("n", "<leader>D", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        map("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        map("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        map("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        map("n", "<leader>rl", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary,

        if client and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, ev.buf)
        end
      end,
    })
    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local servers = {
      html = {},
      cssls = {},
      tailwindcss = {},
      rust_analyzer = {},
      basedpyright = {},
      ruff = {},

      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    for name, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend("force", {}, capabilities or {}, config.capabilities or {})

      config.handlers = vim.tbl_deep_extend("force", {}, handlers or {}, config.handlers or {})
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end
  end,
}
