return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
      -- recent files plugin
      { "smartpde/telescope-recent-files" },
    },
    config = function()
      -- local trouble = require("trouble.providers.telescope")
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "recent_files")

      local map = require("parth.helpers.keys").map
      map("n", "<leader>fr", require("telescope").extensions.recent_files.pick, "Recently opened")
      map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
      map("n", "<leader>/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, "Search in current buffer")

      map("n", "<leader>ff", require("telescope.builtin").find_files, "Files")
      map("n", "<leader>fr", require("telescope.builtin").lsp_references, "References")
      map("n", "<leader>fm", require("telescope.builtin").marks, "Marks")
      map("n", "<leader>fj", require("telescope.builtin").jumplist, "Jump List")
      map("n", "<leader>fh", require("telescope.builtin").help_tags, "Help")
      map("n", "<leader>fw", require("telescope.builtin").grep_string, "Current word")
      map("n", "<leader>fg", require("telescope.builtin").live_grep, "Grep")
      map("n", "<leader>fb", require("telescope.builtin").buffers, "Grep")
      map("n", "<leader>fd", require("telescope.builtin").diagnostics, "Diagnostics")
      map("n", "<leader>gd", require("telescope.builtin").lsp_definitions, "Definitions")
      map("n", "<leader>gi", require("telescope.builtin").lsp_implementations, "Implementations")

      map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    -- This is your opts table
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
