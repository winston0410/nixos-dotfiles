local setup = function()
  vim.api.nvim_exec([[
  augroup SmartUndo
  autocmd!
  autocmd InsertEnter * normal! mu 
  augroup END]], true)
  -- autocmd BufRead * normal! mu 

  -- autocmd InsertEnter * normal! mu 
  vim.cmd('nnoremap u u`u')
end

return {
  setup = setup
}

