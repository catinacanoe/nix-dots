{ plugins, ... }:
let
    config = /* lua */ ''{
        "f-person/git-blame.nvim",
        
        lazy = true,
        cmd = {
            "GitBlameCopyCommitURL",
            "GitBlameCopyFileURL",
            "GitBlameCopySHA",
            "GitBlameDisable",
            "GitBlameEnable",
            "GitBlameOpenCommitURL",
            "GitBlameOpenFileURL",
            "GitBlameToggle",
        },
        keys = {
            { "<leader>g", vim.cmd.GitBlameToggle }
        },

        opts = {},
        config = function(_, _)
            vim.g.gitblame_enabled = false;
            vim.g.gitblame_message_template = " ~ <author> ~ <date> ~ <summary>"
            vim.g.gitblame_date_format = '%a %d.%m.%Y * %H:%M'
            vim.g.gitblame_message_when_not_committed = " ~ not commited"
        end,
    }'';
in {
    plugin."${plugins}/gitblame.lua".text = "return {${config}}";
}
