local M = {}

function M.load()
    package.loaded["matugen-generated"] = nil
    package.loaded["matugen-noctalia.theme"] = nil

    local ok, groups, term = pcall(function()
        return require("matugen-noctalia.theme").get()
    end)

    if not ok then
        vim.notify("matugen-noctalia: " .. tostring(groups), vim.log.levels.WARN)
        return
    end

    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end
    vim.o.termguicolors = true
    vim.g.colors_name = "matugen-noctalia"

    for group, spec in pairs(groups) do
        vim.api.nvim_set_hl(0, group, spec)
    end
    for i, color in ipairs(term) do
        vim.g["terminal_color_" .. (i - 1)] = color
    end
end

function M.setup()
    vim.api.nvim_create_autocmd("Signal", {
        group = vim.api.nvim_create_augroup("MatugenReload", { clear = true }),
        pattern = "SIGUSR1",
        callback = function()
            if vim.g.colors_name == "matugen-noctalia" then
                vim.cmd.colorscheme("matugen-noctalia")
            end
        end,
    })
end

return M
