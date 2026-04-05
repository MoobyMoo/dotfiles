return {
  {
    -- Completion plugin used for popup suggestions while typing.
    "saghen/blink.cmp",
    -- Tell LazyVim how to merge list-like source options if they are extended later.
    opts_extend = { "sources.default" },
    opts = {
      fuzzy = {
        prebuilt_binaries = {
          -- Allow the fuzzy-matching binary even if its recorded version differs.
          ignore_version_mismatch = true,
        },
      },
    },
  },
}
