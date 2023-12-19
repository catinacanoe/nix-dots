{ pkgs, xremap , homeDirectory }:

pkgs.writeShellScriptBin "xremap-start" ''

echo "$@" > /tmp/xremap.log

${pkgs.psmisc}/bin/killall xremap -q
${xremap}/bin/xremap --watch=config,device ${homeDirectory}/.config/xremap/config.yml >> /tmp/xremap.log &

''
