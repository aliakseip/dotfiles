-- Load core settings and keymaps early
require("core.options")
require("core.remaps")

-- Setup plugin manager and plugins
require("core.lazy")

-- Load all features in one go
require("features")
