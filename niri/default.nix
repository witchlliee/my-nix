{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./xdg.nix
    ./settings.nix
    ./keybinds.nix
    ./window-rules.nix
    ./autostart.nix
  ];
}
