local function init(paq)
  paq{'norcalli/nvim-colorizer.lua', config = function ()

  require'colorizer'.setup{}
  end}
end

return {
  init = init
}


