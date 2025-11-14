{ ... }: {
    # UNFINISHED
    # ON THE CURRENT VERSION OF NIXOS, RCLOUD DOESN'T SUPPORT ICLOUD
    programs.rclone = {
        enable = false;
        remotes = {
            icloud = {
                config = {
                    type = "asd";
                };
            };
        };
    };
}
