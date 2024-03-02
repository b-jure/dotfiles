require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- C formatter
        c = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        "--style=file:/home/dlroweht/.config/formatting/.clang-format",
                        "-i"
                    },
                    stdin = false
                }
            end
        },
        -- Lua formatter
        lua = {
            function()
                return {
                    exe = "lua-format",
                    args = {
                        "--config=/home/dlroweht/.config/formatting/lua-format"
                    },
                    stdin = true
                }
            end
        }
    }
}
