return {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify", -- optional
    opts = {
        mapping = {
            startStopRecording = "<leader>q",
            playMacro = "Q",
            switchSlot = "<C-q>",
            editMacro = "cq",
            deleteAllMacros = "dq",
            yankMacro = "yq",
            -- ⚠️ this should be a string you don't use in insert mode during a macro
            addBreakPoint = "##",
        }
    },
}
