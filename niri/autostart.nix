{ config, lib, pkgs, ... }:

{
  programs.niri.settings = {
   spawn-at-startup = [
     { command = ["noctalia-shell"]; }
     { command = ["swww-daemon"]; }
     { command = ["steam" "-silent"]; }
     { command = ["heroic"]; }
     { command = ["discord"]; }
  ];
};
}
