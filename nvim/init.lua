-- Load core settings and keymaps early
require("core.options")
require("core.remaps")
require("core.config")

-- Setup plugin manager and plugins
require("core.lazy")

-- Load all custom plugins
require("custom_plugins")
