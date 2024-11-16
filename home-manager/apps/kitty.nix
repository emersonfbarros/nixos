{ pkgs, ... }:
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
      cursor_shape = "block";
      select_by_word_characters = "@-./_~?&=%+#";
      repaint_delay = 10;
      term = "xterm-kitty";
      open_url_with = "default";
      scrollback_lines = 10000;
      cursor_blink_interval = "0.6";
      cursor_trail = 3;
    };

    shellIntegration = {
      mode = "no-cursor";
      enableZshIntegration = true;
    };

    keybindings = {
      "f1" = "launch --stdin-source=@screen_scrollback nvim";
      "ctrl+shift+s" = ''launch --type overlay --title "ktab" ktab'';
      "ctrl+shift+enter" = "launch --cwd=current";
      "ctrl+shift+n" = "set_tab_title";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+alt+v" = "paste_from_selection";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+alt+c" = "copy_to_selection";
      "ctrl+l" = "clear_log_notice";
      "shift+up" = "scroll_line_up";
      "shift+down" = "scroll_line_down";
      "shift+page_up" = "scroll_page_up";
      "shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+equal" = "increase_font_size";
      "ctrl+minus" = "decrease_font_size";
    };
  };

  home.file.".config/kitty/tab_bar.py".source =
    let
      file = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/emersonfbarros/dotfiles/main/kitty/.config/kitty/tab_bar.py";
        sha256 = "O+tBluL0mihQqSmYphIIszhhuMg3tFMOEe3OEucsFo4=";
      };
    in
    file;
}
