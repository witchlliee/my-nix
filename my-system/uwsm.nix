{ config, pkgs, lib,... }:

let
  # wrapper script for `binPath` since the option type is `path`
  niriSession = lib.getExe (
    pkgs.writeShellScriptBin "niriSession" ''
      ${lib.getExe config.programs.niri.package } --session
    ''
  );
in
{

  xdg.terminal-exec.enable = true;

  programs = {
    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Niri managed by UWSM";
          binPath = niriSession;
        };
      };
    };
  };
 
  environment.systemPackages = with pkgs; [
    app2unit
  ];

}
