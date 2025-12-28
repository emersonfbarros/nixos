{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Emerson Barros";
        email = "emersonfb99@gmail.com";
      };

      gpg.program = "${pkgs.gnupg}/bin/gpg2";

      url = {
        "ssh://git@github.com" = {
          insteadOf = ''https://github.com'';
        };
      };

      delta = {
        navigate = true;
        side-by-side = true;
      };
    };
    signing = {
      key = "5C2B1DF2F1C83884";
      signByDefault = true;
      format = "openpgp";
    };
  };
}
