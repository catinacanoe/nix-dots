{ pkgs, ... }: with (import ../rice); {
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            # systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
                gfxmodeEfi = "${toString monitor.primary.width}x${toString monitor.primary.height}";
                # theme = pkgs.catppuccin-grub;
                theme = pkgs.stdenv.mkDerivation {
                    pname = "grub-theme-catpuccin";
                    version = "0";
                    src = pkgs. fetchFromGitHub {
                        owner = "catppuccin";
                        repo = "grub";
                        rev = "2a5c8be8185dae49dd22030df45860df8c796312";
                        hash = "sha256-20D1EcV8SWOd5BLdAc6FaQu3onha0+aS5yA/GK8Ra0g=";
                    };
                    # the path below is the path from repo root to theme folder
                    installPhase = "cp -r src/catppuccin-mocha-grub-theme $out";
                };
            };
        };

        initrd.preLVMCommands = /*sh*/ ''
            echo -en "\e]P0${col.bg.hex}" #black
            echo -en "\e]P8${col.t3.hex}" #darkgrey
            echo -en "\e]P1${col.brown.hex}" #darkred
            echo -en "\e]P9${col.red.hex}" #red
            echo -en "\e]P2${col.green.hex}" #darkgreen
            echo -en "\e]PA${col.green.hex}" #green
            echo -en "\e]P3${col.orange.hex}" #brown
            echo -en "\e]PB${col.yellow.hex}" #yellow
            echo -en "\e]P4${col.blue.hex}" #darkblue
            echo -en "\e]PC${col.blue.hex}" #blue
            echo -en "\e]P5${col.purple.hex}" #darkmagenta
            echo -en "\e]PD${col.purple.hex}" #magenta
            echo -en "\e]P6${col.aqua.hex}" #darkcyan
            echo -en "\e]PE${col.aqua.hex}" #cyan
            echo -en "\e]P7${col.t5.hex}" #lightgrey
            echo -en "\e]PF${col.fg.hex}" #white
            clear
        '';
    };
}

