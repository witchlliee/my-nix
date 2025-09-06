{ config, pkgs, inputs, lib, inherit, ... }:

{
 
   imports = 
     [ inputs.niri.nixosModules.niri ];
 
    # polkit
  systemd.user.services.niri-flake-polkit.enable = false;
  security.soteria = {
    enable = true;
  };

    # portals
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        niri = {
          default = [ "gnome" "gtk"];
           "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
      };
      extraPortals = [
       pkgs.xdg-desktop-portal-gtk
       pkgs.xdg-desktop-portal-gnome
      ];
    };
  };

    # niri
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable.overrideAttrs (o: {
        patches = (o.patches or [ ]) ++ [
          (pkgs.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/YaLTeR/niri/pull/2333.diff";
            hash = "sha256-MN3/GyuTKEj7GIZEN/woFzY3xD/tSSeddvvKpAt6czc=";
            name = "fullscreen-refactor";
           })
        ];
      });
    };
  };

}
