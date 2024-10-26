{ pkgs, ... }:
{
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.emerson = {
      isNormalUser = true;
      description = "emerson";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = [ ];
    };
  };
}
