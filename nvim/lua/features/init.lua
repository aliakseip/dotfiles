local feature_list = { "menu", "terminal" }

for _, feature in ipairs(feature_list) do
	local ok, mod = pcall(require, "features." .. feature)
	if ok and type(mod.setup) == "function" then
		mod.setup()
	end
end
