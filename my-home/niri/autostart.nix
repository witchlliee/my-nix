{ config, lib, pkgs, ... }:

{
  programs.niri.settings = {
   spawn-at-startup = [
     { sh = "qs -c noctalia-shell"; }
    # { sh = "waypaper --restore"; }
     { sh = "steam -silent"; }
     { command = ["heroic"]; }
     { command = ["discord"]; }
  ];
};
}
