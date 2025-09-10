{ config, pkgs, lib, ...}:

{

  imports = [
    ./swayfx.nix
    ./general.nix
    ./keybinds.nix
    ./autostart.nix
  ];

}
