{ config, ... }:

{

   wayland.windowManager.sway.extraConfig = ''
     corner_radius 6
     blur enable
     blur passes 2
     blur radius 3
     shadows on
   '';

}
