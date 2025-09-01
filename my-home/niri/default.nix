{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./window-rules.nix
    ./autostart.nix
  ];
}
