{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      devshells.default = {
        commands = [
          {
            name = "update";
            help = "Update flake.lock and commit";
            command = ''
              echo "=> Updating flake inputs"
              nix flake update

              git add flake.lock
              git commit -m "chore: update flake.lock"
            '';
          }
          {
            name = "rebuild";
            help = "Rebuild and switch to a NixOS configuration";
            command = ''
              hostname=''${1:-$(hostname)}
              echo "=> Rebuilding system '$hostname'"
              sudo nixos-rebuild switch --flake .#$hostname
            '';
          }
          {
            name = "fmt";
            help = "Format all Nix files";
            command = ''
              nix fmt
            '';
          }
        ];

        packages = with pkgs; [
          nixfmt
          nil
        ];
      };
    };
}
