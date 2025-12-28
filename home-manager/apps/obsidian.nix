{
  programs.obsidian = {
    enable = true;

    vaults."cerebro" = {
      enable = true;

      settings.hotkeys = {
        "app:toggle-left-sidebar" = [
          {
            modifiers = [ "Mod" ];
            key = "[";
          }
        ];
        "app:toggle-right-sidebar" = [
          {
            modifiers = [ "Mod" ];
            key = "]";
          }
        ];
      };
    };
  };
}
