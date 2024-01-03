{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.git-blame-nvim;
    type = "lua";
    config = /* lua */ ''
        require("gitblame").setup()

        vim.keymap.set("n", "<leader>g", vim.cmd.GitBlameToggle)

        vim.g.gitblame_enabled = false;
        vim.g.gitblame_message_template = " ~ <author> ~ <date> ~ <summary>"
        vim.g.gitblame_date_format = '%a %d.%m.%Y * %H:%M'
        vim.g.gitblame_message_when_not_committed = " ~ not commited"
    '';
}
