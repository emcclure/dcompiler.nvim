-- Create a namespace for the plugin
local dcompiler = {}

-- Function to compile the current D source file
function dcompiler.compile_current_file()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.expand('%:p:h')
  local compile_command = "dmd " .. current_file

  -- Run the compile command
  vim.cmd("!" .. compile_command)
end

function dcompiler.dub_compile_project()
		local current_file = vim.api.nvim_buf_get_name(0)
		local project_root = vim.fn.expand("%:p:h:h")
		local original_dir = vim.loop.cwd()
		
		--go up one level in the directory
		vim.fn.chdir(project_root)

		--run the dub compile command
		vim.cmd("!dub build")

		--return to the original directory
		vim.fn.chdir(original_dir)
end

-- Create a command to compile the current file
vim.api.nvim_create_user_command('DCompile', dcompiler.compile_current_file, {})
vim.api.nvim_create_user_command('DubCompile', dcompiler.dub_compile_project, {})

return dcompiler

