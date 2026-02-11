{ config, ... }:
let
    canoe = (import ../../private/mail/canoe.nix { inherit config; });
    marklif = (import ../../private/mail/marklif.nix { inherit config; });
    school = (import ../../private/mail/school.nix { inherit config; });

    gen-mutt-gmail = (import ./gen-mutt-gmail.nix);
    gen-mbsync-gmail = (import ./gen-mbsync-gmail.nix);
in
{
    home.file.".mbsyncrc".text = ''
    ${(gen-mbsync-gmail canoe)}
    ${(gen-mbsync-gmail marklif)}
    ${(gen-mbsync-gmail school)}
    '';

    xdg.configFile."mutt/muttrc-canoe".text = gen-mutt-gmail canoe;
    xdg.configFile."mutt/muttrc-marklif".text = gen-mutt-gmail marklif;
    xdg.configFile."mutt/muttrc-school".text = gen-mutt-gmail school;
}
