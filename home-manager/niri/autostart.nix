{ config, lib, pkgs, ... }:

{
  programs.niri.settings = {
   spawn-at-startup = [
     { command = ["qs"]; }
     { command = ["waypaper" "--restore"]; }
     { command = ["steam" "-silent"]; }
     { command = ["heroic"]; }
     { command = ["discord"]; }
  ];
};
}
