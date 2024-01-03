{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.cellular-automaton-nvim;
    type = "lua";
    config = /* lua */ ''
    local animate =  function()
        local rand = math.random(1,3)
        if (rand == 1) then
            vim.cmd("CellularAutomaton make_it_rain")
        elseif (rand == 2) then
            vim.cmd("CellularAutomaton game_of_life")
        else
            vim.cmd("CellularAutomaton scramble")
        end
    end
    vim.api.nvim_create_user_command("FUCK", animate, {})
    vim.api.nvim_create_user_command("Fuck", animate, {})
    vim.keymap.set("n", "<leader>fuck", animate)
    '';
}
