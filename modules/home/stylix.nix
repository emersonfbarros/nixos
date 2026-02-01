{ inputs, ... }:
{
  flake.modules.homeManager.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.homeModules.stylix ];

      stylix = {
        enable = true;
        # Using builtin scheme from base16-schemes
        base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
        image = pkgs.fetchurl {
          url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/gruv-understand.png";
          sha256 = "13hn21109vcwp55r18vwcccjqmslcmv5vqmw0vx75afnacjzq481";
        };
        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.iosevka-term;
            name = "IosevkaTerm Nerd Font Mono";
          };
          sansSerif = {
            name = "Noto Sans";
            package = pkgs.noto-fonts;
          };
          serif = {
            name = "Noto Serif";
            package = pkgs.noto-fonts;
          };
          emoji = {
            package = pkgs.noto-fonts-emoji-blob-bin;
            name = "Noto Color Emoji";
          };
          sizes = {
            terminal = 12;
          };
        };
        polarity = "dark";
      };

      gtk.iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };
}
