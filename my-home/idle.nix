{ config, pkgs, ... }:

{
   
  services.swayidle =
 let
  lock = "/run/current-system/sw/bin/qs -c noctalia-shell ipc call lockScreen toggle";
  display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
 in
 {
  enable = true;
  timeouts = [
    {
      timeout = 500; # in seconds
      command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
    }
    {
      timeout = 505;
      command = lock;
    }
    {
      timeout = 510;
      command = display "off";
      resumeCommand = display "on";
    }
   # {
    #  timeout = 600;
    #  command = "${pkgs.systemd}/bin/systemctl suspend";
   # }
  ];
  events = [
    {
      event = "before-sleep";
      # adding duplicated entries for the same event may not work
      command = (display "off") + "; " + lock;
    }
    {
      event = "after-resume";
      command = display "on";
    }
    {
      event = "lock";
      command = (display "off") + "; " + lock;
    }
    {
      event = "unlock";
      command = display "on";
    }
  ];
  };
}
