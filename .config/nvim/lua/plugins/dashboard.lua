return {
    "nvimdev/dashboard-nvim",
    dependecies = {
        "nvim-tree/nvim-web-devicons",
    },
    priority = 999,
    event = "VimEnter",
    lazy = false,
    opts = {
        theme = "doom",
        config = {
            week_header = {
                enable = true,
            },
        },
    },
}
