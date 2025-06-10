local experiment_list = { }

for _, experiment in ipairs(experiment_list) do
  local ok, mod = pcall(require, "experiments." .. experiment)
  if ok and type(mod.setup) == "function" then
    mod.setup()
  end
end
