{
  window = {
    padding = {
      x = 10;
      y = 10;
    };
    dynamic_padding = false;
    dynamic_title = true;
  };

  font = {
    normal = {
      family = "Input Mono Compressed";
      style = "Regular";
    };
    bold = {
      style = "Bold";
    };
    italic = {
      style = "Italic";
    };
    bold_italic = {
      style = "Bold Italic";
    };

    size = 11.5;
    scale_with_dpi = false;

    offset = {
      x = 0;
      y = 0;
    };
    glyph_offset = {
      x = 0;
      y = 0;
    };
  };

  draw_bold_text_with_bright_colors = false;

  colors = {
    primary = {
      background = "#2E3440";
      foreground = "#E5E9F0";
    };
    cursor = {
      text = "CellBackground";
      cursor = "CellForeground";
    };
    selection = {
      text = "CellBackground";
      background = "CellForeground";
    };
    vi_mode_cursor = {
      text = "CellBackground";
      background = "CellForeground";
    };
    normal = {
      black = "#3B4252";
      red = "#BF616A";
      green = "#A3BE8B";
      yellow = "#EBCB8B";
      blue = "#5E81AC";
      magenta = "#B48EAD";
      cyan = "#88C0D0";
      white = "#ECEFF4";
    };
  };

  live_config_reload = true;

  cursor.style.shape = "Block";

  env."WINIT_X11_SCALE_FACTOR" = "1";
}

