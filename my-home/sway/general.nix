{ config, pkgs, lib, ...}:

{
  
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    config = rec {
      output = {
        DP-1 = {
          mode = "1920x1080@239.96Hz";
          adaptive_sync = "off";
          allow_tearing = "yes";
          render_bit_depth = "8";
          color_profile = "srgb";
          max_render_time = "off";
        };
      };
      input = {
        "*" = {
          xkb_layout = "br";
        };
      };
      gaps = {
        inner = 6;
        outer = 6;
      };
      colors = {
        focused = {
          background = lib.mkForce "#cba6f7";
          border = lib.mkForce "#cba6f7";
          childBorder = lib.mkForce "#cba6f7";
          indicator = lib.mkForce "#cba6f7";
        };
        unfocused = {
          background = lib.mkForce "#505050";
          border = lib.mkForce "#505050";
          childBorder = lib.mkForce "#505050";
          indicator = lib.mkForce "#505050";
          text = lib.mkForce "#505050";
        };
      };
      bars = [ ];
      floating = {
        border = 4;
        titlebar = false;
      };
      window = {
        border = 4;
        commands = [
         {
          command = "opacity 0.95";
          criteria = {
            class = ".*";
          };
         }
        ];
        titlebar = false;
      };
    };
  };

}
