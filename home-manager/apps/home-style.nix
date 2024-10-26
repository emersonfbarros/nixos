{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    image = pkgs.fetchurl {
      url = "https://blenderartists.org/uploads/default/original/4X/3/f/8/3f85b760b6b5dcf9e14ab35a409a19d8cc676e53.jpeg";
      sha256 = "1s8v0k8nj5m5p21kdv850qk1xys6ylnwygy8fsdn1qnlr5bryci4";
    };
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "Lilex" ]; };
        name = "Lilex Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji-blob-bin;
        name = "Noto Color Emoji";
      };
    };
    polarity = "dark";
    targets.mako.enable = false;
  };

  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };
}
