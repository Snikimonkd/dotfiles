local current_signature = function()
    if not pcall(require, 'lsp_signature') then return end
    local sig = require("lsp_signature").status_line(max_width)
    return sig.label
end

require('lualine').setup{
    options = { theme = 'gruvbox-material' }
}
