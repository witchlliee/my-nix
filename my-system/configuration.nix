# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, self, inputs, lib, ... }:

{

  imports =
    [
      ./hardware-configuration.nix
      ./security.nix
      ./autoupgrade.nix
      ./ssd.nix
      ./gaming.nix
      ./niri.nix
    ];

  # Bootloader.
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot = {
     kernelPackages = pkgs.linuxPackages_cachyos;
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

  services.power-profiles-daemon.enable = true;
 
  security.polkit.enable = true;

  services.udisks2.enable = true;

  xdg.terminal-exec.enable = true;

  networking.hostName = "my-nix"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

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

  services.xserver.xkb.layout = "br";
  
  services.displayManager.gdm.enable = true;

  console.keyMap = "br-abnt2";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
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
  };

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
    (_: prev: {
      mesa_git = prev.mesa_git.overrideAttrs (o: {
        patches = (o.patches or []) ++ [
            ./37293.patch
        ];
      });
    })
  ];

  services.ananicy = {
    enable = true;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  services.flatpak.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  
  stylix = {
    enable = true;
    # image = ./wallpapers/wallhaven-qr2zj5_3840x2160.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  chaotic.mesa-git.enable = true;

  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.lact.enable = true;

  environment.systemPackages = with pkgs; [
    clamav

    inputs.quickshell.packages.${system}.default
    inputs.swww.packages.${system}.swww
   
    vim
    bluez
    wget
    pavucontrol
    stow
   
    base16-schemes
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
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
