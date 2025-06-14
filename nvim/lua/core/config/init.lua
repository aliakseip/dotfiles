local config_list = { "menu", "terminal" }

for _, config in ipairs(config_list) do
	local ok, mod = pcall(require, "config." .. config)
	if ok and type(mod.setup) == "function" then
		mod.setup()
	end
end
