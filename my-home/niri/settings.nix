{ config, pkgs, ... }:

{

  programs.niri = {
    settings = {

      prefer-no-csd = true;

      hotkey-overlay = {
        skip-at-startup = true;
      };

      layout = {

        background-color = "transparent";

        border = {
          enable = true;
          width = 4;
          active = {
            color = "cba6f7";
          };
          inactive = {
            color = "#505050";
          };
        };

         focus-ring = {
           enable = false;
         };

        gaps = 10;

        struts = {
          left = 16;
          right = 16;
          top = 16;
          bottom = 16;
        };
      };

      input = {
        keyboard.xkb.layout = "br";
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = false;
      };

      outputs = {
        "DP-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 239.964;
          };
          variable-refresh-rate = "on-demand";
          scale = 1.0;
          position = { x = 0; y = 0; };
        };
      };

      cursor = {
        size = 24;
        theme = "Bibata-Modern-Ice";
      };
 
      environment = {
          # wayland
        "NIXOS_OZONE_WL" = "1";
        "SDL_VIDEODRIVER" = "wayland,x11,windows";
        "QT_QPA_PLATFORM" = "wayland";
        "GDK_BACKEND" = "wayland";
        
          # gaming specific
        "PROTON_USE_WAYLAND" = "1";
        "PROTON_USE_WOW64" = "1";
      }; 
    };
  };

}
