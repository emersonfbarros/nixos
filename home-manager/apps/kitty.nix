{
  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "yes";
      enabled_layouts = "stack,tall";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_edge = "top";
      tab_bar_style = "custom";
      tab_separator = ''" "'';
      tab_title_template = ''" {sup.index} {title}{bell_symbol}{activity_symbol} "'';
      active_tab_title_template = ''" {sup.index} {title}{bell_symbol}{activity_symbol} "'';
    };
  };
}
