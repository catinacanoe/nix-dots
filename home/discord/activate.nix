{ config, ... }:
/* bash */ ''
cat ${config.xdg.configHome}/Vencord-gen/settings/settings.json > ${config.xdg.configHome}/Vencord/settings/settings.json
cat ${config.xdg.configHome}/Vencord-gen/themes/Translucence.theme.css > ${config.xdg.configHome}/Vencord/themes/Translucence.theme.css
''
