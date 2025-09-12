{ config, pkgs, inputs, self, ...}:

{

  system.autoUpgrade = {
    enable = true;
    flake = "github:witchlliee/my-nix";
    flags = [
      "--print-build-logs"
      "--recreate-lock-file"
      "--commit-lock-file"
    ];
    dates = "12:00";
  };

}
