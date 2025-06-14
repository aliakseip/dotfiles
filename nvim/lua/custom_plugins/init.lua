local custom_plugins_list = { "floaterminal" }

for _, custom_plugin in ipairs(custom_plugins_list) do
  local ok, mod = pcall(require, "custom_plugins." .. custom_plugin)
  if ok and type(mod.setup) == "function" then
    mod.setup()
  end
end
