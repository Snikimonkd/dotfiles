local keymap = vim.keymap 

require('dap-go').setup {}

keymap.set("n", "<leader>bp", ":DapToggleBreakpoint<CR>")
keymap.set("n", "<leader>dw", function ()
    local widgets = require('dap.ui.widgets');
    local sidebar = widgets.sidebar(widgets.scopes, nil, "bot split");
    sidebar.open();
end)

keymap.set("n", "<leader>dt", require("dap-go").debug_test)
keymap.set("n", "<leader>so", require("dap").step_over)
keymap.set("n", "<leader>si", require("dap").step_into)
keymap.set("n", "<leader>ds", require("dap").terminate)
keymap.set("n", "<leader>dk", require('dap.ui.widgets').hover)

