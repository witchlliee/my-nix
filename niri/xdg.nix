{ pkgs, ... }:

{
  xdg.portal = {
    config.niri = {
      default = [ "gnome" "gtk" ];
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
    };
    extraPortals = [ pkgs.xdg-xdg-desktop-portal-gtk ];
  };
}
