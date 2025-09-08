{ config, pkgs, inputs, self, ...}:

{

  system.autoUpgrade = {
    enable = true;
    flake = "github:witchlliee/my-nix";
    flags = [
      "--print-build-logs"
    ];
    dates = "06:40";
  };

}
