
{ config, lib, pkgs, modulesPath, ... }:
let
    hostname = import (../ignore-hostname.nix);
in
{
    networking.networkmanager.wifi.powersave = false;

} // (if hostname == "nixbox" then {
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true; # to allow video memory to persist through suspend (hyprland crashy crashy)
        powerManagement.finegrained = false; # experimental but i am supported

        open = false; # but i am supported
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    # suggested for suspend (but i didn't need it [yet])
    # boot.extraModprobeConfig = ''
    # options nvidia NVreg_RegistryDwords="OverrideMaxPerf=0x1"
    # options nvidia NVreg_PreserveVideoMemoryAllocations=1
    # '';
} else if hostname == "nixpad" then {
    # networking.networkmanager.wifi.macAddress = "stable"; # default preserve

    # sound stuff
    boot.extraModprobeConfig = ''
        options snd slots=snd-hda-intel
        options snd_hda_intel enable=0,1
    '';

    # hardware.opengl.enable = true;
} else {})
