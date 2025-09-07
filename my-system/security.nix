{ config, pkgs, ... }:

{

  security = {
     apparmor = {
        enable = true;
        enableCache = true;
        packages = with pkgs; [
           apparmor-profiles
        ];
     };
  };

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

  networking.firewall.enable = true;

}
