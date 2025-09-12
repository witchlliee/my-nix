{ config, lib, pkgs, self, inputs, ... }:

{
      home.username = "ellie";
      home.homeDirectory = "/home/ellie";

  programs = {
     fish = {
        enable = true;
        shellAliases = {
          nix-update = "sudo nix flake update --flake ~/my-nix && sudo nixos-rebuild switch --flake ~/my-nix";
        };
        interactiveShellInit = ''
          set fish_greeting
          starship init fish | source
          fastfetch
        '';
     };
  };
  
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "ghostty";
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };

  programs.git = {
    enable = true;
    userName  = "witchlliee";
    userEmail = "witchlliee@tuta.io";
    aliases = {
       ci = "commit";
       co = "checkout";
       s = "status";
    };
  };
  
  programs.ghostty.enable = true;
 
  imports = [
    ./niri/default.nix
    ./idle.nix
  ];
  
  home.packages = with pkgs; [
       # media
     discord
     vivaldi
     spotify

       # desktop
     app2unit
     swayidle
     wlogout
     waypaper
     mpvpaper
     kdePackages.dolphin
     kdePackages.ffmpegthumbs
     kdePackages.kio-extras
     kdePackages.qtsvg
     kdePackages.qt6ct
     kdePackages.dolphin-plugins
     qt6Packages.qt5compat
     kdePackages.qt5compat
     libsForQt5.qt5.qtgraphicaleffects
     kdePackages.qtbase
     kdePackages.qtdeclarative
     kdePackages.qtstyleplugin-kvantum
     kdePackages.qtwayland
     libsForQt5.qt5.qtwayland
     egl-wayland
     kdePackages.qtimageformats
     material-symbols
     wl-clipboard
     cliphist
     nwg-look
     libnotify
     grim
     slurp
     swappy
     bluez
     gearlever
     gpu-screen-recorder
     gpu-screen-recorder-gtk
     mpv
 
       # theming
     bibata-cursors
     starship

       # fonts
     nerd-fonts.jetbrains-mono
     roboto-mono
     inter-nerdfont
  
       # tools
     arch-install-scripts
     kdePackages.kservice
     fastfetch
     btop
     lsof
     usbutils
     xorg.xeyes
     xorg.xlsclients
     kdePackages.ark
     kdePackages.dolphin-plugins
     unrar 
     jq
     autotiling-rs
 
       # libs
     glfw
     gnutls
     libgcc
     gcc
     gh
     sdl3
     SDL2
     SDL
  ];
        home.stateVersion = "25.05";
  }

       
