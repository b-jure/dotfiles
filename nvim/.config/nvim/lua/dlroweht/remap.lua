local function map_key(modes, k, v)
    vim.keymap.set(modes, k, v, { noremap = true, silent = true })
end

-- <leader> key
vim.g.mapleader = " "

-- enter command mode but in neovim window
-- WARNING: LSP bugg upon entering the window second time
map_key("n", "<C-f>", ":<C-s>i")

-- resize panes
map_key({ "n", "i" }, "<M-U>", "<Esc>:vertical resize +5<CR>")
map_key({ "n", "i" }, "<M-P>", "<Esc>:vertical resize -5<CR>")
map_key({ "n", "i" }, "<M-O>", "<Esc>:horizontal resize +5<CR>")
map_key({ "n", "i" }, "<M-I>", "<Esc>:horizontal resize -5<CR>")

-- go to next/prev quickfix list item
map_key("n", "[q", "<cmd>cn<CR>")
map_key("n", "]q", "<cmd>cp<CR>")

-- set/unset spelling
map_key("n", "[os", "<cmd>set spell<CR>")
map_key("n", "]os", "<cmd>set nospell<CR>")

-- recenter and invert jumping to misspelled word
map_key("n", "]s", "[szz")
map_key("n", "[s", "]szz")

-- enable/disable syntax highlighting
map_key("n", "[oS", "<cmd>syntax on<CR>")
map_key("n", "]oS", "<cmd>syntax off<CR>")

-- insert space above/below cursor
map_key("n", "<Space>[", "O<Escape>")
map_key("n", "<Space>]", "o<Escape>")

-- indent text without exiting visual mode
map_key("v", "<", "<gv")
map_key("v", ">", ">gv")

-- keep register clean after pasting in visual mode
map_key("v", "p", '"_dP')

-- source
map_key("n", "<leader>vs", "<cmd>so $MYVIMRC<CR>")

-- delete the block
map_key("n", "daf", "da}")

-- movement
map_key({ "n", "v" }, "j", "h")
map_key({ "n", "v" }, "k", "j")
map_key({ "n", "v" }, "l", "k")
map_key({ "n", "v" }, ";", "l")

-- move selected lines up/down
map_key("v", "K", ":m '>+1<CR>gv=gv")
map_key("v", "L", ":m '<-2<CR>gv=gv")

-- move half screen down/up and recenter
map_key("n", "<C-d>", "<C-d>zz")
map_key("n", "<C-u>", "<C-u>zz")

-- move to next/prev match and recenter
map_key("n", "n", "nzz")
map_key("n", "N", "Nzz")

-- delete without polluting primary register
map_key("n", "<leader>d", '"_d')
map_key("v", "<leader>d", '"_d')

-- disable arrow keys
map_key({ "n", "x", "i" }, "<up>", "<nop>")
map_key({ "n", "x", "i" }, "<down>", "<nop>")
map_key({ "n", "x", "i" }, "<left>", "<nop>")
map_key({ "n", "x", "i" }, "<right>", "<nop>")

-- exit
map_key({ "n", "x", "v" }, "q", "<cmd>q<CR>")
map_key("n", "<leader>q", "<cmd>q!<CR>")
map_key("n", "M", "q")

-- no highlight
map_key({ "n", "x", "v" }, "<leader>h", ":noh<CR>")

-- write (save)
map_key("n", "<leader>w", ":w<CR>")

-- Fix * (cursor stays stays on the first match)
map_key("n", "*", "*N")

-- sort
map_key("v", "<C-s>", "<cmd>!sort<CR>")

-- to upper
map_key("n", "<leader>U", "gUiwe")
-- to lower
map_key("n", "<leader>u", "guiwe")

-- remap directional delete
map_key("n", "dl", "dk")
map_key("n", "dk", "dj")

-- better command mode navigation
map_key("c", "<C-a>", "<Cmd>normal! ^<CR>")
map_key("c", "<C-e>", "<Cmd>normal! $<CR>")
map_key("c", "<C-b>", "<Cmd>call feedkeys('<Left>')<CR>")
map_key("c", "<C-f>", "<Cmd>call feedkeys('<Right>')<CR>")
map_key("c", "<C-j>", "<Cmd>call feedkeys('<S-Left>')<CR>")
map_key("c", "<C-;>", "<Cmd>call feedkeys('<S-Right>')<CR>")

-- insert newline without leaving normal mode
map_key("n", "<leader>n", "o<Esc>");

-- pane manipulation
map_key({ "n", "v" }, "<C-w>j", "<C-w>H")
map_key({ "n", "v" }, "<C-w>k", "<C-w>J")
map_key({ "n", "v" }, "<C-w>l", "<C-w>K")
map_key({ "n", "v" }, "<C-w>;", "<C-w>L")

-- wildmenu selection confirmation
vim.keymap.set('c', '<Space>', function()
  if vim.fn.wildmenumode() == 1 then
    return "<C-y>"
  else
    return "<Space>"
  end
end, { expr = true, noremap = true })

-- Reverse chars while in regular visual mode
local function revchars(lines, start_pos, end_pos)
  local first_line = start_pos[2]
  local nlines = #lines
  for i = 1, nlines do
    local linenr = (first_line-1) + i
    local line = lines[i]
    local revpart, suffix, prefix
    if i == 1 then -- first line?
      prefix = line:sub(1, start_pos[3] - 1)
      if #lines > 1 then -- have mutliple lines?
        -- reverse from selection start to end of line
        revpart = line:sub(start_pos[3], #line):reverse()
        suffix = ""
      else -- only a single line
        -- reverse from selection start to cursor
        revpart = line:sub(start_pos[3], end_pos[3]):reverse()
        suffix = line:sub(end_pos[3] + 1)
      end
    elseif i == nlines then -- last line?
      -- reverse from start to cursor
      prefix = ""
      revpart = line:sub(1, end_pos[3]):reverse()
      suffix = line:sub(end_pos[3] + 1)
    else -- line in between
      -- reverse the whole line
      prefix = ""
      revpart = line:reverse()
      suffix = ""
    end
    vim.fn.setline(linenr, prefix .. revpart .. suffix)
  end
end

-- Reverse chars while in visual line mode
local function revlines(lines, start_pos)
  local first_line = start_pos[2]
  local nlines = #lines
  for i = 1, nlines do
    vim.fn.setline((first_line-1) + i, lines[i]:reverse())
  end
end

-- Reverse chars while in visual block mode
local function revcharsbox(lines, start_pos, end_pos)
  local first_line = start_pos[2]
  local nlines = #lines
  for i = 1, nlines do
    local linenr = (first_line-1) + i
    local line = lines[i]
    local scol = (start_pos[3] > #line) and #line or start_pos[3]
    local ecol = (end_pos[3] > #line) and #line or end_pos[3]
    local prefix = line:sub(1, scol - 1)
    local revpart = line:sub(scol, ecol):reverse()
    local suffix = line:sub(ecol + 1)
    vim.fn.setline(linenr, prefix .. revpart .. suffix)
  end
end


local function get_positions_and_mode()
    local mode = vim.fn.mode()
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    -- Swap positions in case selection start line is greater then the
    -- cursor position, or the lines are same but selection start column
    -- is greater than the cursor column
    if (start_pos[2] > end_pos[2]) or
       (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
      local temp = start_pos
      start_pos = end_pos
      end_pos = temp
    end

    return mode, start_pos, end_pos
end

function vim.g.dlroweht_revchars()
    local mode, start_pos, end_pos = get_positions_and_mode()
    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    if mode == "v" then -- visual mode?
        revchars(lines, start_pos, end_pos)
    elseif mode == "V" then -- visual line mode?
        revlines(lines, start_pos)
    elseif mode == "\22" then -- visual block mode?
        revcharsbox(lines, start_pos, end_pos)
    end
end

vim.api.nvim_set_keymap("v", "<Space>r", "", {
  callback = function()
    vim.g.dlroweht_revchars()
  end
})

function vim.g.dlroweht_terminate()
  local mode, start_pos, end_pos = get_positions_and_mode()
  if mode == "V" then
    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    local nlines = #lines
    for i = 1, nlines do
      vim.fn.setline((start_pos[2]-1) + i, lines[i] .. ";")
    end
    local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(key, "v", false)
    vim.api.nvim_win_set_cursor(0, {start_pos[2], start_pos[3]})
  end
end

vim.api.nvim_set_keymap("v", "<Space>;", "", {
  callback = function()
    vim.g.dlroweht_terminate()
  end
})
