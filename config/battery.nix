{ config, ... }:
{
    # # better scheduling for cpu cycles
    # services.system76-scheduler.settings.cfsProfiles.enable = true;

    # # tlp is better than gnome (below)
    # services.tlp = {
    #     enable = true;
    #     settings = {
    #         CPU_BOOST_ON_AC = 0;
    #         CPU_BOOST_ON_BAT = 0;
    #         CPU_SCALING_GOVERNOR_ON_AC = "powersave";
    #         CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    #     };
    # };

    # # disable gnome power mgmt
    # services.power-profiles-daemon.enable = false;

    # allow upower battery predictor to run
    services.upower.enable = true;

    # cpufreq
    services.auto-cpufreq.enable = true;

    # enable powertop
    powerManagement.powertop.enable = true;
}
