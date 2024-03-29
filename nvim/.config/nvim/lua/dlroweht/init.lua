--[[
 ________  ___       ________  ________  ___       __   _______   ___  ___  _________   
|\   ___ \|\  \     |\   __  \|\   __  \|\  \     |\  \|\  ___ \ |\  \|\  \|\___   ___\ 
\ \  \_|\ \ \  \    \ \  \|\  \ \  \|\  \ \  \    \ \  \ \   __/|\ \  \\\  \|___ \  \_| 
 \ \  \ \\ \ \  \    \ \   _  _\ \  \\\  \ \  \  __\ \  \ \  \_|/_\ \   __  \   \ \  \  
  \ \  \_\\ \ \  \____\ \  \\  \\ \  \\\  \ \  \|\__\_\  \ \  \_|\ \ \  \ \  \   \ \  \ 
   \ \_______\ \_______\ \__\\ _\\ \_______\ \____________\ \_______\ \__\ \__\   \ \__\
    \|_______|\|_______|\|__|\|__|\|_______|\|____________|\|_______|\|__|\|__|    \|__|

--]] --
require("dlroweht.settings")
require("dlroweht.packer")
require("dlroweht.remap")
require("colorizer").setup()

-- Great for observing log files that get
-- constantly updated
vim.o.updatetime = 1000 -- 1 second
vim.api.nvim_create_autocmd({"CursorHold", "BufRead"}, {
	pattern = {"*.dbg.txt"}, -- only for debug output files
	command = "checktime | call feedkeys('G')",
})
