{
  description = "my-flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    swww.url = "github:LGFae/swww";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, chaotic, niri, quickshell, stylix, ... }@inputs: {
    nixosConfigurations = {
      my-nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./my-system/configuration.nix
          chaotic.nixosModules.default
          stylix.nixosModules.stylix
          home-manager.nixosModules.default
          {
            home-manager = {
               useGlobalPkgs = true;
               useUserPackages = true;
               extraSpecialArgs = { inherit self inputs; };
               users.ellie = import ./my-home/home.nix;
            };
          }
        ];
      };
    };
  };
}
