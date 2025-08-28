{ config, pkgs, ...}:

{
    programs.niri.settings = {

       layer-rules = [
       {
         matches = [ 
           { namespace = "^swww-daemon$"; }
         ];
           place-within-backdrop = true;
       }
       
       {
         matches = [
           { namespace = "^quickshell-wallpaper$"; }
         ];
       }
 
       {
         matches = [
           { namespace = "^quickshell-overview$"; }
         ];
           place-within-backdrop = true;
       }
       ];

       window-rules = [
       {
         matches = [
           { app-id = ".*\.exe"; }
           { app-id = "steam_app_.*"; }
           { app-id = "steam_app_[0-9]+"; }
           { app-id = "org.vinegarhq.Sober"; }
        ];
           variable-refresh-rate = true;
        }
        
        {
        matches = [
           { app-id="steam"; title="^notificationtoasts_\d+_desktop$"; }
        ];   
           default-floating-position = {
              x = 10;
              y = 10;
           relative-to = "bottom-right";
           };        
        }

        {
        matches = [
           { app-id = "discord"; }
        ];
           open-on-workspace = "1";
        }

        {
          matches = [
             { app-id = "firefox"; title = "Picture-in-Picture"; }
             { app-id = "org.kde.dolphin"; }
             { title = "Select Background Image"; }
             { app-id = "Vivaldi-stable"; title = "Vivaldi Settings: General - Vivaldi"; }
             { app-id = "[Ss]team"; }
             { app-id = "steam"; title = "Steam Settings"; }
             { app-id = "org.pulseaudio.pavucontrol"; }
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
           draw-border-with-background = false;
        }
      ];

    };
}
