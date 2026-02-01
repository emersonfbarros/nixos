# NVIDIA + Steam gaming configuration
# This should only be imported on hosts with NVIDIA GPU
{
  flake.modules.nixos.games =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      hardware.graphics.enable32Bit = true;

      services.xserver.videoDrivers = [ "nvidia" ];

      # Optimus PRIME setup
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          # integrated
          intelBusId = "PCI:00:02:0";
          # dedicated
          nvidiaBusId = "PCI:00:01:0";
        };
      };

      # Gaming specialisation - sync mode for better performance
      specialisation = {
        gaming-time.configuration = {
          hardware.nvidia = {
            prime.sync.enable = lib.mkForce true;
            prime.offload = {
              enable = lib.mkForce false;
              enableOffloadCmd = lib.mkForce false;
            };
          };
        };
      };

      # Game launchers and helpers
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      programs.gamemode.enable = true;

      environment.systemPackages = with pkgs; [
        mangohud
        protonup-ng # must run `protonup` command after installation
      ];

      environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    };
}
