{ pkgs, lib, config, ... }:
{
  imports = [
    ./i3status-rust.nix
  ];
  config = lib.mkIf config.enableSway {
    wayland.windowManager.sway = {
      enable = true;
      checkConfig = false;
      config = rec {
        modifier = "Mod4";
        left = "h";
        down = "j";
        up = "k";
        right = "l";
        terminal = "kitty";
        menu = "wmenu-run";

        output = {
          "*" = {
            bg = "/home/mw/Wallpapers/dark_blue_background.png fill";
          };
        };

        input = {
          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            natural_scroll = "enabled";
            middle_emulation = "enabled";
          };
          "type:keyboard" = {
            xkb_layout = "dk";
          };
        };

        keybindings = {
          # Basics
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+q" = "kill";
          "${modifier}+d" = "exec ${menu}";
          "${modifier}+f" = "exec firefox";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

          # Moving around
          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${right}" = "move right";
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # Workspaces
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          # Layout
          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";
          "${modifier}+a" = "focus parent";

          # Scratchpad
          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          # Resize mode + screenshot
          "${modifier}+r" = "mode resize";
          "Print" = "exec grim";
        };

        modes = {
          resize = {
            "${left}" = "resize shrink width 10 px";
            "${down}" = "resize grow height 10 px";
            "${up}" = "resize shrink height 10 px";
            "${right}" = "resize grow width 10 px";
            "Left" = "resize shrink width 10 px";
            "Down" = "resize grow height 10 px";
            "Up" = "resize shrink height 10 px";
            "Right" = "resize grow width 10 px";
            "Return" = "mode default";
            "Escape" = "mode default";
          };
        };

        bars = [{
          position = "top";
          statusCommand = "i3status-rs ${config.xdg.configHome}/i3status-rust/config-top.toml";
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            focusedWorkspace = {
              border = "#e67e22";
              background = "#e67e22";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#e67e22";
              background = "#e67e22";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#2b2b2b";
              background = "#2b2b2b";
              text = "#ffffff";
            };
          };
        }];
      };

      # Things the structured options can't express:
      extraConfig = ''
        # --locked bindings (the keybindings attrset can't add flags)
        bindsym --locked XF86AudioMute exec pactl set-sink-mute \@DEFAULT_SINK@ toggle
        bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume \@DEFAULT_SINK@ -5%
        bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume \@DEFAULT_SINK@ +5%
        bindsym --locked XF86AudioMicMute exec pactl set-source-mute \@DEFAULT_SOURCE@ toggle

        bindsym --locked XF86AudioPlay exec playerctl play-pause
        bindsym --locked XF86AudioPause exec playerctl play-pause
        bindsym --locked XF86AudioPrev exec playerctl previous
        bindsym --locked XF86AudioNext exec playerctl next
        bindsym --locked XF86AudioStop exec playerctl stop

        bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-
        bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+

        include /etc/sway/config.d/*
      '';
    };

  home.packages = with pkgs; [
    swaybg
    wofi
    grim
    slurp
    wl-clipboard
    swaylock
    swayidle
  ];

  };
}
