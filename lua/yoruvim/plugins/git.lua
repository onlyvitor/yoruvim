return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(lhs, action, desc)
          vim.keymap.set("n", lhs, action, { buffer = bufnr, desc = desc })
        end
        map("]h", function() gs.nav_hunk("next") end, "Proximo hunk")
        map("[h", function() gs.nav_hunk("prev") end, "Hunk anterior")
        map("<leader>gs", gs.stage_hunk, "Stage ou unstage hunk")
        map("<leader>gu", gs.reset_hunk, "Descartar hunk")
        map("<leader>gp", gs.preview_hunk, "Previsualizar hunk")
        map("<leader>gb", gs.toggle_current_line_blame, "Alternar blame da linha")
      end,
    },
  },
}
