{ config, pkgs, ...}:

{

   wayland.windowManager.sway.config.startup = [
     { command = "qs -c noctalia-shell"; }
     { command = "~/my-nix/my-home/sway/scripts/vrr_fullscreen.sh"}
     { command = "app2unit -- steam -silent"; }
     { command = "app2unit -- heroic"; }
     { command = "app2unit -- discord"; }
   ];

}
