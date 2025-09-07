{ config, pkgs, inputs, lib, ... }:

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
      package = pkgs.niri-unstable;
    };
  };

}
