{pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      shell = "fish";
      enable_audio_bell = "no";
      tab_bar_style = "hidden";
      confirm_os_window_close = 0;
      scrollback_lines = 5000;
      wheel_scroll_multiplier = 5.0;
      # UI stuff
      background_opacity = 1.0;
      foreground = "#abb2bf";
      background = "#282c34";
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      cursor = "#e07b39";
      cursor_text_color = "#282c34";
      selection_foreground = "#abb2bf";
      selection_background = "#3e4451";
      url_color = "#E07B39";
      # black
      color0 = "#282c34";
      color8 = "#5c6370";
      # red
      color1 = "#e06c75";
      color9 = "#e06c75";
      # green
      color2 = "#98c379";
      color10 = "#98c379";
      # yellow
      color3 = "#e5c07b";
      color11 = "#e5c07b";
      # blue
      color4 = "#61afef";
      color12 = "#61afef";
      # magenta
      color5 = "#c678dd";
      color13 = "#c678dd";
      # cyan
      color6 = "#56b6c2";
      color14 = "#56b6c2";
      # white
      color7 = "#abb2bf";
      color15 = "#d7dae0";
      font_family = "JetBrains Mono";
      font_size = 10.0;
      bold_font = "auto";
      italic_font = "auto";

      # Better font rendering
      adjust_line_height = "120%";
      adjust_column_width = "100%";

      
    };
    keybindings = {
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+c" = "copy_to_clipboard";
    };
  };
  home.packages = with pkgs; [
    kitty
  ];
}
