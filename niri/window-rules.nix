{ config, pkgs, ...}:

{
    programs.niri.settings = {
       window-rules = [
        {
        matches = [
           { app-id = "^.*\.exe$"; }
        ];
         variable-refresh-rate = true;
        }

        {
        matches = [
           { app-id = "vesktop"; }
        ];
         open-on-workspace = "1";
        }

        {
        matches = [
           { app-id = "firefox"; }
           { title = "Picture-in-Picture";}
           { app-id = "org.kde.dolphin";}
         ];
            open-floating = true;
         }

        {
           matches = [{}];
           opacity = 0.95;
           geometry-corner-radius = {
               top-left = 6.0;
               top-right = 6.0;
               bottom-left = 6.0;
               bottom-right = 6.0;
           };
           clip-to-geometry = true;
        }
      ];

    };
}
