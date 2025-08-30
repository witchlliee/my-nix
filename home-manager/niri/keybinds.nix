{ lib, config, pkgs, ... }:

 {
    programs.niri.settings.binds = with config.lib.niri.actions;

 {

    "Mod+Q".action = close-window;
    "Mod+A".action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];
    "Mod+E".action.spawn = "dolphin";
    "Mod+T".action.spawn = "ghostty";
    "Mod+D".action.spawn = ["noctalia-shell" "ipc" "call" "sidePanel" "toggle"];
    "Mod+Shift+E".action.spawn = ["noctalia-shell" "ipc" "call" "powerPanel" "toggle"];

    "Mod+F".action = maximize-column;
    "Mod+V".action = toggle-window-floating;

    "Mod+P".action = screenshot;
    "Mod+Shift+P".action.screenshot-screen = [];
    "Mod+Ctrl+P".action = screenshot-window;

    "Mod+Left".action = focus-column-left;
    "Mod+Down".action = focus-window-down;
    "Mod+Up".action = focus-window-up;
    "Mod+Right".action = focus-column-right;
    "Mod+L".action = focus-column-left;
    "Mod+K".action = focus-window-down;
    "Mod+I".action = focus-window-up;
    "Mod+J".action = focus-column-right;

    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;
    "Mod+Shift+6".action.move-column-to-workspace = 6;
    "Mod+Shift+7".action.move-column-to-workspace = 7;
    "Mod+Shift+8".action.move-column-to-workspace = 8;
    "Mod+Shift+9".action.move-column-to-workspace = 9;

  };
}
