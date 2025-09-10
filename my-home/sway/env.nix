{ config, ...}:

{

    wayland.windowManager.sway.extraSessionCommands = 
    ''
    export SDL_VIDEODRIVER=wayland,x11,windows
    export QT_QPA_PLATFORM=wayland
    export PROTON_ENABLE_WAYLAND=1
    export GDK_BACKEND=wayland
    export ELECTRON_OZONE_PLATFORM_HINT=wayland

    export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    '';
  
}
