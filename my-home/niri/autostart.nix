{ config, lib, pkgs, ... }:

{
  programs.niri.settings = {
   spawn-at-startup = [
     { sh = "qs -c noctalia-shell"; }
    # { sh = "waypaper --restore"; }
     { sh = "app2unit -- steam -silent"; }
     { sh = "app2unit -- heroic"; }
     { sh = "app2unit -- discord"; }
  ];
};
}
