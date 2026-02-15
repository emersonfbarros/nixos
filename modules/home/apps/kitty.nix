{
  flake.modules.homeManager.kitty =
    { pkgs, ... }:
    {
      programs.kitty = {
        enable = true;
        settings = {
          font_family = ''"family='IosevkaTerm Nerd Font Mono'"'';
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";

          allow_remote_control = "yes";
          enabled_layouts = "stack,tall";
          active_tab_font_style = "normal";
          font_size = 12;
          inactive_tab_font_style = "normal";
          tab_bar_edge = "top";
          tab_bar_style = "custom";
          tab_separator = ''" "'';
          tab_title_template = ''" {sup.index} {title}{bell_symbol}{activity_symbol} "'';
          active_tab_title_template = ''" {sup.index} {title}{bell_symbol}{activity_symbol} "'';
          cursor_shape = "block";
          select_by_word_characters = "@-./_~?&=%+#";
          repaint_delay = 10;
          open_url_with = "default";
          term = "xterm-kitty";
          scrollback_lines = 10000;
          cursor_blink_interval = "0.6";
          cursor_trail = 5;
        };

        shellIntegration = {
          mode = "no-cursor";
          enableZshIntegration = true;
        };

        keybindings = {
          "ctrl+shift+s" = ''launch --type overlay --title "kitab" kitab'';
          "ctrl+shift+7" = "launch --type overlay kiwindow 0";
          "ctrl+shift+8" = "launch --type overlay kiwindow 1";
          "ctrl+shift+9" = "launch --type overlay kiwindow 2";
          "ctrl+shift+0" = "launch --type overlay kiwindow 3";

          "f1" = "launch --stdin-source=@screen_scrollback nvim";
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
    };
}
