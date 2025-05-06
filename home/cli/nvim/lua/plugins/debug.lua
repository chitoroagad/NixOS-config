return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',
	},
	keys = {
		{
			'<leader>dc',
			function()
				require('dap').continue()
			end,
			desc = "[D]ebug: Start/[C]ontinue",
		},
		{
			'<leader>dsi',
			function()
				require('dap').step_into()
			end,
			desc = "[D]ebug: [S]tep [I]nto",
		},
		{
			'<leader>dso',
			function()
				require('dap').step_over()
			end,
			desc = "[D]ebug: [S]tep [O]ver",
		},
		{
			'<leader>dsO',
			function()
				require('dap').step_our()
			end,
			desc = "[D]ebug: [S]tep [O]ut",
		},
		{
			'<leader>db',
			function()
				require('dap').toggle_breakpoint()
			end,
			desc = "[D]ebug: Toggle [B]reakpoint"
		},
		{
			'<leader>dB',
			function()
				require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
			end,
			desc = "[D]ebug: Set [B]reakpoint",
		},
		{
			'<leader>dr',
			function()
				require('dapui').toggle()
			end,
			desc = "[D]ebug: See Last Session [R]esult",

		},
	},

	config = function()
		local dap = require('dap')
		local dapui = require('dapui')

		dapui.setup {
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
					disconnect = '⏏',
				},
			},
		}

		-- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end


		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close
	end
}
