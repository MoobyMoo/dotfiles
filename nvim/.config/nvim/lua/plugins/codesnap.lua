return {
  {
    -- Community plugin that turns selected code into styled snapshot images.
    -- This file is your local config for that plugin.
    "mistricky/codesnap.nvim",
    -- Build the image generator used by the plugin.
    build = "bash ./scripts/build_generator.sh",
    cmd = {
      -- Only load the plugin when one of these commands is used.
      "CodeSnap",
      "CodeSnapASCII",
      "CodeSnapHighlight",
      "CodeSnapHighlightSave",
      "CodeSnapSave",
    },
    keys = {
      -- These mappings only matter in visual mode because CodeSnap works on selected text.
      { "<leader>cC", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save Snapshot" },
      { "<leader>cS", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save Snapshot" },
    },
    opts = {
      -- Do not show the workspace root in the exported image header.
      show_workspace = false,
      -- Include line numbers in snapshots.
      show_line_number = true,
      snapshot_config = {
        -- Color theme used for syntax highlighting in the image.
        theme = "catppuccin-mocha",
        window = {
          -- Hide the fake macOS title bar in the image.
          mac_window_bar = false,
          shadow = {
            -- Remove shadow from the generated image.
            radius = 0,
            color = "#00000000",
          },
          margin = {
            -- Add a small margin around the code in the snapshot.
            x = 8,
            y = 8,
          },
          border = {
            -- Remove border around the generated snapshot window.
            width = 0,
            color = "#00000000",
          },
          title_config = {
            -- Hide title text by making it transparent, but keep a font defined.
            color = "#00000000",
            font_family = "JetBrainsMono Nerd Font",
          },
        },
        code_config = {
          -- Font used in the code image.
          font_family = "JetBrainsMono Nerd Font",
          breadcrumbs = {
            -- Do not show file breadcrumbs in the snapshot.
            enable = false,
          },
        },
        line_number_color = "#6c7086",
        -- Transparent background.
        background = "#00000000",
        watermark = {
          -- Disable watermark by making it blank and transparent.
          content = " ",
          color = "#00000000",
          font_family = "JetBrainsMono Nerd Font",
        },
      },
    },
    config = function(_, opts)
      -- First initialize the plugin normally with the options above.
      require("codesnap").setup(opts)

      -- Pull in internal plugin modules so we can override some default behavior.
      -- This is more advanced than normal plugin configuration and depends on
      -- CodeSnap internals staying compatible.
      local codesnap = require("codesnap")
      local generator = require("codesnap.module").load_generator(true)
      local config_module = require("codesnap.config")
      local modal = require("codesnap.modal")
      local static = require("codesnap.static")
      local path_utils = require("codesnap.utils.path")
      local string_utils = require("codesnap.utils.string")
      local table_utils = require("codesnap.utils.table")
      local visual_utils = require("codesnap.utils.visual")

      -- Override how CodeSnap builds its final snapshot configuration.
      -- This custom version reads the current visual selection, computes the
      -- file path shown in the image, and resolves the configured color theme.
      config_module.get_config = function()
        local code = visual_utils.get_selected_text()
        local start_line_number = static.config.show_line_number and visual_utils.get_start_line_number() or nil

        if string_utils.is_str_empty(code) then
          error("No code is selected", 0)
        end

        local full_path = vim.fn.expand("%:p")
        local relative_path = full_path ~= "" and path_utils.get_relative_path() or "[No Name]"
        local file_path = static.config.show_workspace and path_utils.get_workspace() .. "/" .. relative_path
          or relative_path

        return table_utils.assign(static.config.snapshot_config, {
          content = {
            content = code,
            start_line_number = start_line_number,
            file_path = file_path,
          },
          theme = generator.parse_code_theme(static.config.snapshot_config.theme),
        })
      end

      -- Default directory/filename for saved images.
      local function default_save_path()
        local dir = vim.fn.expand("~/Pictures/CodeSnap")
        vim.fn.mkdir(dir, "p")
        return string.format("%s/codesnap-%s.png", dir, os.date("%Y-%m-%d_%H-%M-%S"))
      end

      -- Ask the generator to write the final image file.
      local function save_snapshot(file_path, config)
        generator.save(file_path, config)
      end

      -- Save to a user path if provided, otherwise use the default timestamped path.
      local function write_snapshot(config, file_path)
        file_path = file_path and file_path ~= "" and vim.fn.expand(file_path) or default_save_path()
        save_snapshot(file_path, config)
        -- Clear the previous visual marks after exporting.
        vim.cmd("delmarks <>")
        vim.notify("Saved snapshot to " .. file_path)
      end

      -- Replace the plugin's default copy/save helpers with your custom save behavior.
      function codesnap.copy()
        write_snapshot(config_module.get_config())
      end

      function codesnap.save(file_path)
        write_snapshot(config_module.get_config(), file_path)
      end

      function codesnap.copy_highlight()
        local original_config = config_module.get_config()
        if not original_config or not original_config.content or not original_config.content.content then
          vim.notify("No code is selected", vim.log.levels.ERROR)
          return
        end

        local selected_text = original_config.content.content
        local filetype = vim.bo.filetype

        modal.pop_modal(selected_text, filetype, function(selection)
          if not selection then
            vim.notify("Selection cancelled", vim.log.levels.INFO)
            return
          end

          local lines = vim.split(selected_text, "\n", { plain = true })
          local start_line, end_line = selection[1], selection[2]

          if start_line < 1 or end_line > #lines or start_line > end_line then
            vim.notify("Invalid selection range", vim.log.levels.ERROR)
            return
          end

          local config = config_module.get_config()
          config.content.highlight_lines = {
            { start_line, end_line, static.config.highlight_color },
          }

          write_snapshot(config)
        end)
      end

      -- Re-register user commands so they use the customized functions above.
      vim.api.nvim_create_user_command("CodeSnap", function()
        codesnap.copy()
      end, { nargs = 0, range = "%", force = true })

      vim.api.nvim_create_user_command("CodeSnapSave", function(detail)
        codesnap.save(detail.args)
      end, { nargs = "?", range = "%", force = true, complete = "file" })

      vim.api.nvim_create_user_command("CodeSnapHighlight", function()
        codesnap.copy_highlight()
      end, { nargs = 0, range = "%", force = true })
    end,
  },
}
