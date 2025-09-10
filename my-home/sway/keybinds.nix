{ config, pkgs, lib, ... }:

{

  wayland.windowManager.sway = {
    config = rec {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "qs -c noctalia-shell ipc call launcher toggle";
      keybindings =
        let
           modifier = config.wayland.windowManager.sway.config.modifier;
           terminal = config.wayland.windowManager.sway.config.terminal;
           menu = config.wayland.windowManager.sway.config.menu;	
        in 
        lib.mkOptionDefault {
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";
 
        "${modifier}+j" = "focus left";
        "${modifier}+l" = "focus right";
        "${modifier}+i" = "focus up";
        "${modifier}+k" = "focus down";

        "${modifier}+t" = "exec app2unit -- ${terminal}";
        "${modifier}+q" = "kill";
        "${modifier}+a" = "exec ${menu}";
        "${modifier}+e" = "exec app2unit -- dolphin";
        "${modifier}+c" = "exec app2unit -- ghostty -e nvim";
         
        "${modifier}+f" = "fullscreen";
        "${modifier}+v" = "floating toggle";
        };
    };
  };
        
}
