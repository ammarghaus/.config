local function statusline()
    local window_number = "%{winnr()}"
    local file_name = " %f"
    local modified = "%m"
    local align_right = "%="
    local linecol = " %l:%c"
    local percentage = " %P"

    return string.format(
        "[%s]%s%s%s%s%s",
	window_number,
        file_name,
        modified,
        align_right,
        linecol,
        percentage
    )
end

vim.opt.statusline = statusline()
