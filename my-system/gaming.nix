{ config, pkgs, self, ... }:

{
 
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
       proton-ge-bin
       proton-cachyos_x86_64_v3  # chaotic-nyx needed for proton-cachyos package
    ];
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  services.udev.extraRules = ''
      # USB
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGN>
      ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LI>
      # Bluetooth
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  environment.systemPackages = with pkgs; [
       # games & launchers & emulators
     heroic
     lutris
     pokemmo-installer
     prismlauncher
     dolphin-emu
     pcsx2
     rpcs3
     shadps4
     daggerfall-unity

       # tools
     lact
     vulkan-tools
     mangohud
     goverlay
     protonplus

       # wine
     wineWow64Packages.staging
     winetricks
  ];

}
     
