{
  flake.modules.nixos.users =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;

      users = {
        defaultUserShell = pkgs.zsh;

        users.emerson = {
          isNormalUser = true;
          uid = 1000;
          extraGroups = [
            "networkmanager"
            "wheel"
            "seat"
          ];
        };
      };
    };
}
