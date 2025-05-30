{ config, pkgs, ... }:

{
  imports = [ ./waybar.nix ];
  # Enable Hyprland in home-manager
  home.packages = with pkgs; [
    swww
    fuzzel
    dunst
    libnotify
  ];

  # wayland.windowManager.hyprland = {
   #  enable = true;
   #  # Optional: specify Hyprland package if needed
   #  # package = pkgs.hyprland;
  # };

  # Copy your hyprland.conf to ~/.config/hypr/hyprland.conf
  home.file.".config/hypr/hyprland.conf".text = ''
    ####
    # HYPRLAND CONFIGURATION
    # See https://wiki.hyprland.org/Configuring/ for full documentation.
    ####
    
    ####
    ### MONITORS ###
    ####
    monitor=DP-1,3840x2160,0x0,1.5
    monitor=DP-2,3840x2160,3840x0,1.5
    
    ####
    ### PROGRAMS ###
    ####
    $terminal = ghostty -e fish
    $fileManager = dolphin
    $menu = fuzzel
    $dmenu = fuzzel --dmenu
    
    ####
    ### AUTOSTART ###
    ####
    exec-once = swww-daemon
    exec-once = dunst
    exec-once = waybar
    
    ####
    ### ENVIRONMENT VARIABLES ###
    ####
    env = XCURSOR_SIZE,84
    env = HYPRCURSOR_SIZE,120
    
    ####
    ### PERMISSIONS ###
    ####
    # Example: permission = /usr/(bin|local/bin)/grim, screencopy, allow
    
    ####
    ### LOOK AND FEEL ###
    ####
    general {
        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
        resize_on_border = false
        allow_tearing = false
        layout = dwindle
    }
    
    decoration {
        rounding = 10
        rounding_power = 2
        active_opacity = 1.0
        inactive_opacity = 1.0
        shadow {
            enabled = true
            range = 4
            render_power = 3
            color = rgba(1a1a1aee)
        }
        blur {
            enabled = true
            size = 3
            passes = 1
            vibrancy = 0.1696
        }
    }
    
    animations {
        enabled = yes, please :)
        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = almostLinear,0.5,0.5,0.75,1.0
        bezier = quick,0.15,0,0.1,1
        animation = global, 1, 10, default
        animation = border, 1, 5.39, easeOutQuint
        animation = windows, 1, 4.79, easeOutQuint
        animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
        animation = windowsOut, 1, 1.49, linear, popin 87%
        animation = fadeIn, 1, 1.73, almostLinear
        animation = fadeOut, 1, 1.46, almostLinear
        animation = fade, 1, 3.03, quick
        animation = layers, 1, 3.81, easeOutQuint
        animation = layersIn, 1, 4, easeOutQuint, fade
        animation = layersOut, 1, 1.5, linear, fade
        animation = fadeLayersIn, 1, 1.79, almostLinear
        animation = fadeLayersOut, 1, 1.39, almostLinear
        animation = workspaces, 1, 1.94, almostLinear, fade
        animation = workspacesIn, 1, 1.21, almostLinear, fade
        animation = workspacesOut, 1, 1.94, almostLinear, fade
    }
    
    dwindle {
        pseudotile = true
        preserve_split = true
    }
    
    master {
        new_status = master
    }
    
    misc {
        force_default_wallpaper = -1
        disable_hyprland_logo = false
    }
    
    ####
    ### INPUT ###
    ####
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =
        follow_mouse = 1
        sensitivity = 0
        touchpad {
            natural_scroll = false
        }
    }
    
    gestures {
        workspace_swipe = false
    }
    
    device {
        name = epic-mouse-v1
        sensitivity = -0.5
    }
    
    ####
    ### KEYBINDINGS ###
    ####
    $mainMod = SUPER
    
    bind = $mainMod, Q, exec, $terminal
    bind = $mainMod, Return, exec, $terminal
    bind = $mainMod, C, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, D, exec, $dmenu
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, R, exec, $menu
    bind = $mainMod, P, pseudo,
    bind = $mainMod, J, togglesplit,
    
    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d
    
    # Move focus with mainMod + vim keys
    bind = $mainMod, H, movefocus, l
    bind = $mainMod, L, movefocus, r
    bind = $mainMod, K, movefocus, u
    bind = $mainMod, J, movefocus, d
    
    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10
    
    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10
    
    # Special workspace (scratchpad)
    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic
    
    # Scroll through workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1
    
    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    
    # Multimedia keys
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
    
    # Media keys (playerctl)
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous
    
    ####
    ### WINDOWS AND WORKSPACES ###
    ####
    windowrule = suppressevent maximize, class:.*
    windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    
    # End of config
  '';
}
