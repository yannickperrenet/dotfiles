-- `:lua P(var)` e.g. `:lua P(flash)`
P = function(v)
  print(vim.inspect(v))
  return v
end
