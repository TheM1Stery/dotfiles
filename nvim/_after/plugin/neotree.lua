-- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/202#issuecomment-1428278234
-- These two functions were taken from the issue above. So, Thanks!

local delete = function(state)
	local inputs = require("neo-tree.ui.inputs")
	local path = state.tree:get_node().path
	local msg = "Are you sure you want to trash " .. path
	inputs.confirm(msg, function(confirmed)
		if not confirmed then return end

		vim.fn.system { "trash",  path }
		require("neo-tree.sources.manager").refresh(state.name)
	end)
end

-- over write default 'delete_visual' command to 'trash' x n.
local delete_visual = function(state, selected_nodes)
	local inputs = require("neo-tree.ui.inputs")

	-- get table items count
	function GetTableLen(tbl)
		local len = 0
		for n in pairs(tbl) do
			len = len + 1
		end
		return len
	end

	local count = GetTableLen(selected_nodes)
	local msg = "Are you sure you want to trash " .. count .. " files ?"
	inputs.confirm(msg, function(confirmed)
		if not confirmed then return end
		for _, node in ipairs(selected_nodes) do
			vim.fn.system { "trash", node.path }
		end
		require("neo-tree.sources.manager").refresh(state.name)
	end)
end



vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require("neo-tree").setup({
    window = {
        position = "float",
    },
    filesystem = {
        filtered_items = {
            visible = true
        },
        use_libuv_file_watcher = true,
        commands = {
            delete = delete,
            delete_visual = delete_visual,
        },
        hijack_netrw_behavior = "open_current"
    },
})
vim.keymap.set("n", "<leader>tf", vim.cmd.Neotree)
vim.keymap.set("n", "<leader>tt", "<Cmd>Neotree reveal=true position=float toggle <CR>")

