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
     kernelPackages = pkgs.linuxPackages_cachyos-lto;
     initrd.kernelModules = [ "ntsync" ];
     kernelParams = [
        "root=UUID=84b1088f-26d4-4aec-8fa9-09a263571ca3" "rootflags=subvol=@" "rw" "quiet"
     ];
     kernel.sysctl = {
        "kernel.split_lock_mitigate" = 0;
     };
  };

  zramSwap = { 
     enable = true;
     priority = 100;
     memoryPercent = 100;
  };

  boot = {
       tmp = {
           useTmpfs = true;
           cleanOnBoot = true;
       };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
    };
    cpu.intel = {
      updateMicrocode = true;
    };
  };

  services.tuned.enable = true;

  services.clamav = {
     daemon.enable = true;
     updater.enable = true;
     scanner.enable = true;
     fangfrisch = {
        enable = true;
        settings = {
           default = {
              db_url = "sqlite:////var/lib/fangfrisch/db.sqlite";
              local_directory = "/var/lib/clamav";
              max_size = "5MB";
              on_update_exec = "clamdscan --reload";
              on_update_timeout = "42";
           };
       };
     };
  };
             
  services.lact.enable = true;

  security.polkit.enable = true;

  services.udisks2.enable = true;

  fileSystems = 
    {
      "/".options = [ "defaults" "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
      "/home".options = [ "defaults" "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
      "/nix".options = [ "defaults" "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
      "/persist".options = [ "defaults" "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
      "/var/log".options = [ "defaults" "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
      "/var/cache".options = [ "defaults" "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
      "/var/tmp".options = [ "defaults" "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
    };

  fileSystems."/mnt/my-stuff" =
    { 
      device = "/dev/disk/by-uuid/4f00ab65-a229-4fab-994d-004a2f932582";
      fsType = "btrfs";
      options = [ "subvol=/" "defaults" "rw" "noatime" "discard=async" "space_cache=v2" ];
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
      enable = false;
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

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
    enable = true;
    support32Bit = true;
    };
  extraConfig.pipewire."92-low-latency" = {
     "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 128;
        "default.clock.max-quantum" = 128;
      };
    };
  extraConfig.pipewire-pulse."92-low-latency" = {
  context.modules = [
    {
      name = "libpipewire-module-protocol-pulse";
      args = {
        pulse.min.req = "128/48000";
        pulse.default.req = "128/48000";
        pulse.max.req = "128/48000";
        pulse.min.quantum = "128/48000";
        pulse.max.quantum = "128/48000";
      };
    }
  ];
      stream.properties = {
      node.latency = "128/48000";
      resample.quality = 4;
      };
    };
  };

  services.udev.extraRules = ''
      # USB
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      # Bluetooth
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

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
 
  home-manager.users.ellie = { config, lib, pkgs, self, inputs, ... }: {

  programs = {
     fish = {
        enable = true;
        shellAliases = {
          nix-update = "sudo nix flake update --flake ~/my-nix && sudo nixos-rebuild switch --flake ~/my-nix";
        };
        interactiveShellInit = ''
          set fish_greeting
          starship init fish | source
        '';
     };
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
        daggerfall-unity
        dolphin-emu

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

        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        wlogout
        kdePackages.dolphin
        nautilus
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
        kdePackages.polkit-kde-agent-1
        hyprpolkitagent
        catppuccin-kvantum
        papirus-icon-theme
        
        hyprshot
        starship
        bibata-cursors
        bluez
        gearlever
        grim
        slurp
        swappy
        matugen 

        nerd-fonts.jetbrains-mono
        roboto-mono
        inter-nerdfont
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
        vivaldi
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
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  services.ananicy = {
    enable = true;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
  };

  services.flatpak.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.fish.enable = true;

  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
       proton-ge-bin
       proton-cachyos_x86_64_v3
    ];
  };

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      embeddedTheme = "pixel_sakura";
    })
    wineWow64Packages.staging
    winetricks
    clamav
    xwayland-satellite-unstable
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
    inputs.quickshell.packages.${system}.default
    inputs.noctalia.packages.${system}.default
    inputs.swww.packages.${system}.swww
    vim
    bluez
    wget
    kitty
    pavucontrol
    stow
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
