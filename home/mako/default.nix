{ config, ... }:
let
    rice = (import ../../rice);
    fontsize = rice.font.size;
    inherit (rice) col;
in
{
    services.mako = {
        enable = true;
	font = "monospace ${toString fontsize}";
	icons = false;
	actions = false;
	layer = "top";
	anchor = "bottom-right";
	maxVisible = -1;
	ignoreTimeout = true;
	defaultTimeout = 7*1000; # millis

	width = 400;
	height = 150;
	borderSize = rice.window.border;
	borderRadius = rice.window.radius;
	margin = toString rice.window.gaps-out;
	padding = toString rice.window.gaps-in;

	textColor = "#${col.fg}ff";
	borderColor = "#${col.fg}a0";
	backgroundColor = "#${col.bg}b0";
	progressColor = "#${col.aqua}ff";
    };
}
