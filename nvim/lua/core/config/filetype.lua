local M = {}

M.setup = function()
    vim.filetype.add({
        extension = {
            conf = "splunk_conf",
        },
        filename = {
            ["props.conf"] = "splunk_conf",
            ["transforms.conf"] = "splunk_conf",
            ["inputs.conf"] = "splunk_conf",
            ["indexes.conf"] = "splunk_conf",
            ["app.conf"] = "splunk_conf",
            ["authorize.conf"] = "splunk_conf",
            ["web.conf"] = "splunk_conf",
            ["restmap.conf"] = "splunk_conf",
            ["server.conf"] = "splunk_conf",
        },
    })
end

return M
