{ config, pkgs, ... }:

{

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

  fileSystems = {
      "/mnt/my-stuff" =
    {
      device = "/dev/disk/by-uuid/4f00ab65-a229-4fab-994d-004a2f932582";
      fsType = "btrfs";
      options = [ "subvol=/" "defaults" "rw" "noatime" "discard=async" "space_cache=v2" ];
    };

}
