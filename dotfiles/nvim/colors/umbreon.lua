-- ~/.config/nvim/colors/umbreon.lua

-- Reset syntax and existing theme states
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "umbreon"
vim.o.background = "dark"

-- 🎨 Your Exact Custom Terminal Palette 
local colors = {
    bg           = "#1C2124", -- Main Dark Coat
    bg_subtle    = "#414E54", -- Selection Base / Shadow Dark
    fg           = "#FFFFFF", -- Main Text Highlight
    
    ring_yellow  = "#EFCB69", -- Umbreon Ring Yellow
    ring_bright  = "#FFEB89", -- Bright Glow Yellow
    
    eye_crimson  = "#DE635D", -- Umbreon Eye Crimson
    eye_bright   = "#FF837D", -- Bright Glow Crimson
    
    muted_slate  = "#52626A", -- Middle ground color for secondary items
}

-- Utility function to easily attach highlight parameters
local function hl(group, options)
    vim.api.nvim_set_hl(0, group, options)
end

-- 🖥️ User Interface Elements
hl("Normal",       { fg = colors.fg, bg = colors.bg }) 
hl("NormalFloat",  { fg = colors.fg, bg = colors.bg })
hl("CursorLine",   { bg = colors.bg_subtle })          
hl("LineNr",       { fg = colors.muted_slate })             
hl("CursorLineNr", { fg = colors.ring_yellow, bold = true })  
hl("Visual",       { fg = colors.fg, bg = colors.bg_subtle }) 
hl("Search",       { fg = colors.bg, bg = colors.ring_bright })
hl("IncSearch",    { fg = colors.bg, bg = colors.ring_yellow })
hl("MatchParen",   { fg = colors.ring_bright, bg = colors.bg_subtle, bold = true })
hl("Pmenu",        { fg = colors.fg, bg = colors.bg_subtle })
hl("PmenuSel",     { fg = colors.bg, bg = colors.ring_yellow })

-- 📁 Folder & Directory Highlights (Yellow Rings Glow)
hl("Directory",         { fg = colors.ring_yellow, bold = true }) -- Core Netrw/Vim Folders
hl("NvimTreeFolderIcon",{ fg = colors.ring_yellow })              -- NvimTree Folder Icons
hl("NvimTreeFolderName",{ fg = colors.ring_yellow, bold = true }) -- NvimTree Folder Names
hl("NeoTreeDirectoryName",{ fg = colors.ring_yellow, bold = true })-- Neo-tree Folder Names
hl("NeoTreeDirectoryIcon",{ fg = colors.ring_yellow })            -- Neo-tree Folder Icons

-- 📝 Core Coding Syntax Highlighting
hl("Comment",      { fg = colors.muted_slate, italic = true }) 
hl("Keyword",      { fg = colors.ring_yellow, bold = true })   -- local, return, if
hl("Statement",    { fg = colors.ring_yellow })                
hl("Conditional",  { fg = colors.ring_yellow })                
hl("Repeat",       { fg = colors.ring_yellow })                

hl("Function",     { fg = colors.ring_bright })                -- functions and methods
hl("Identifier",   { fg = colors.fg })                         -- variable names

hl("String",       { fg = colors.eye_crimson })                -- "strings look crimson"
hl("Character",    { fg = colors.eye_bright })                 
hl("Constant",     { fg = colors.eye_bright })                 -- true, false, numbers

hl("PreProc",      { fg = colors.ring_yellow })                
hl("Type",         { fg = colors.ring_yellow })                -- int, string, table
hl("Special",      { fg = colors.eye_bright })                 -- special operators or tokens

-- ⚠️ Diagnostics & Status Updates
hl("Error",        { fg = colors.eye_bright, bg = colors.bg })
hl("Todo",         { fg = colors.bg, bg = colors.ring_yellow, bold = true })
hl("Underlined",   { fg = colors.eye_crimson, underline = true })
hl("URL",          { fg = colors.eye_crimson, underline = true })

