{ config, pkgs, ... }:

{

   services = {
     hypridle = {
       enable = true;
       settings = {
          general = {
            after_sleep_cmd = "niri msg action power-on-monitors";
            ignore_dbus_inhibit = false;
            lock_cmd = "qs -c noctalia-shell ipc call lockScreen toggle";
          };

          listener = [
          {
            timeout = 900;
            on-timeout = "qs -c noctalia-shell ipc call lockScreen toggle";
          }
          {
            timeout = 1200;
            on-timeout = "niri msg action power-off-monitors";
            on-resume = "niri msg action power-on-monitors";
          }
          ];
       };
     };
   };

}
