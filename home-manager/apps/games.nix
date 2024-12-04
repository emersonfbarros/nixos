{
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    mangohud.enable = true;
    gamemode.enable = true;

    lutris.enable = true;

    # Exec protonup command in the terminal to install
    protonup.enable = true;
  };

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
