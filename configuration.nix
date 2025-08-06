# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, inputs, ... }:

{

  imports =
    [
      inputs.niri.nixosModules.niri
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot = {
     kernelPackages = pkgs.linuxPackages_cachyos.cachyOverride { mArch = "GENERIC_V3"; };
     initrd.kernelModules = [ "ntsync" ];
     kernelParams = [
        "root=UUID=2bc76c12-6a92-4afa-b87f-da8cb077c7c0" "rootflags=subvol=@" "quiet"
     ];
     kernel.sysctl = {
        "kernel.split_lock_mitigate" = 0;
     };
  };

  zramSwap.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
    };
  };

  xdg.portal = {
     enable = true;
     xdgOpenUsePortal = true;
     config = {
       common.default = ["gtk"];
       hyprland.default = ["gtk" "hyprland"];
     };
     extraPortals = [
       pkgs.xdg-desktop-portal-gtk
     ];
  };

  services.power-profiles-daemon.enable = true;

  security.polkit.enable = true;

  services.udisks2.enable = true;

  fileSystems."/mnt/my-stuff" =
    {
      device = "/dev/disk/by-uuid/b1a4833d-896a-4e1f-8e48-116baf94c1a6";
      fsType = "btrfs";
      options = [ "defaults" "noatime" "compress=zstd" "commit=120" ];
    };

  networking.hostName = "my-nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "br";
        variant = "";
      };
    };
  };


  # Enable the KDE Plasma Desktop Environment.
  services = {
     displayManager = {
         sddm = {
           package = pkgs.kdePackages.sddm;
           extraPackages = with pkgs; [
               sddm-astronaut
               kdePackages.qtsvg
               kdePackages.qtmultimedia
               kdePackages.qtvirtualkeyboard
            ];
           enable = true;
           wayland.enable = true;
           wayland.compositor = "kwin";
           theme = "sddm-astronaut-theme";
       };
    };
  };

  services.desktopManager.plasma6.enable = false;

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    alsa = {
    enable = true;
    support32Bit = true;
    };
  };

  services.blueman.enable = true;

  services.udev.extraRules = ''
      # USB
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      # Bluetooth
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ellie = {
    isNormalUser = true;
    description = "Ellie";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "input" "video" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  home-manager.users.ellie = { config, pkgs, self, inputs, ... }: {
  programs.fish = {
     enable = true;
     interactiveShellInit = ''
       set fish_greeting
       starship init fish | source
     '';
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

  imports = [
       ./niri/default.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Magenta-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };


   home.packages = with pkgs; [
        discord
        lutris
        pokemmo-installer
        prismlauncher
        protonplus
        proton-cachyos

        xwayland
        mangohud
        goverlay
        btop
        libsndfile
        usbutils
        ananicy-rules-cachyos_git
        vulkan-tools
        dxvk
        glxinfo
        lsof
        
        glfw
        gnutls
        libgcc
        gcc
        gh

        xdg-desktop-portal-hyprland
        dunst
        wlogout
        walker
        kdePackages.dolphin
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
        kdePackages.qtimageformats
        material-symbols
        wl-clipboard
        nwg-look
        libnotify
        hyprpolkitagent
        hyprshot
        starship
        bibata-cursors
        bluez
        gearlever
        grim
        slurp
        swappy

        nerd-fonts.jetbrains-mono
        catppuccin-kde
        catppuccin-qt5ct

        arch-install-scripts
        pnpm
        nodejs_24
        esbuild
        electron_37-bin
        kdePackages.kservice

        fastfetch

        spotify
   ];

  home.stateVersion = "25.05";
  };

  nix = {
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    (_: prev: {
      mesa = prev.mesa.overrideAttrs (o: {
        patches = (o.patches or []) ++ [
            ./min_image_count.patch
        ];
      });
    })
  ];

  services.ananicy = {
    enable = true;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
  };

  services.flatpak.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.hyprland = {
     enable = true;
     package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
     portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
     withUWSM = false;
     xwayland = {
        enable = true;
     };
  };

  programs.waybar.enable = true;

  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;

  programs.fish.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      embeddedTheme = "pixel_sakura";
    })
    gnutls
    openldap
    libgpg-error
    freetype
    sqlite
    libxml2
    xml2
    SDL
    SDL2
    sdl3
    gperftools
    heroic
    inputs.quickshell.packages.${pkgs.system}.default
    inputs.swww.packages.${pkgs.system}.swww
    vim
    bluez
    wget
    kitty
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
