{ config, lib, pkgs, ... }:

{
  programs.niri.settings = {
   spawn-at-startup = [
     { command = ["systemctl" "--user" "start" "hyprpolkitagent"]; }
     { command = ["qs"]; }
     { command = ["swww-daemon"]; }
     { command = ["waypaper" "--restore"]; }
     { command = ["heroic"]; }
     { command = ["discord"]; }
  ];
};
}
