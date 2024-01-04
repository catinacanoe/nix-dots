{ plugins, ... }:
let
    config = /* lua */ ''{
        "Eandrju/cellular-automaton.nvim",

        lazy = true,
        cmd = {
            "CellularAutomaton",
            "FUCK",
            "Fuck",
        },
        keys = {
            { "<leader>fuck", animate },
        },

        config = function(_, _)
            vim.api.nvim_create_user_command("FUCK", animate, {})
            vim.api.nvim_create_user_command("Fuck", animate, {})
        end
    }'';
in {
    plugin."${plugins}/cellular-automaton.lua".text= ''
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

        return {
            ${config}
        }
    '';
}
