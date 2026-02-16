{
  flake.modules.nixos.media-server = {

    # Create a dedicated group and user for media services
    users =
      let
        mediaId = 911;
      in
      {
        groups.media.gid = mediaId;
        users.media = {
          isSystemUser = true;
          group = "media";
          uid = mediaId;
          description = "Media Server User";
        };
        users.emerson.extraGroups = [ "media" ];
      };

    # Open firewall ports for Local Network Access
    networking.firewall = {
      allowedTCPPorts = [
        8096 # Jellyfin HTTP
        8920 # Jellyfin HTTPS
        8180 # qBittorrent WebUI
        8989 # Sonarr
        7878 # Radarr
        9696 # Prowlarr
        6767 # Bazarr
        5055 # Jellyseerr
        4080 # Heimdall HTTP
        40443 # Heimdall HTTPS
        8191 # ByParr (Flaresolverr alternative)
      ];
      allowedUDPPorts = [
        1900 # Jellyfin DLNA
        7359 # Jellyfin Auto-Discovery
      ];
    };

    # Declaratively create directories with correct permissions
    systemd.tmpfiles.rules = [
      # Media directories
      "d /media/servarr           0775 media media -"
      "d /media/servarr/downloads 0775 media media -"

      # Service configuration directories
      "d /srv/qbittorrent         0775 media media -"
      "d /srv/sonarr              0775 media media -"
      "d /srv/radarr              0775 media media -"
      "d /srv/prowlarr            0775 media media -"
      "d /srv/bazarr              0775 media media -"
      "d /srv/jellyfin            0775 media media -"
      "d /srv/heimdall            0775 media media -"
      "d /srv/jellyseerr          0775 media media -"
    ];

    # Forces VA-API to use the Intel Media Driver (iHD) instead of the legacy driver (i965)
    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

    virtualisation.oci-containers = {
      backend = "podman";

      containers =
        let
          mediaIdStr = "911"; # Match the UID defined above
          commonEnv = {
            TZ = "America/Sao_Paulo";
            PUID = mediaIdStr;
            PGID = mediaIdStr;
          };
        in
        {
          prowlarr = {
            image = "ghcr.io/linuxserver/prowlarr:latest";
            ports = [ "9696:9696" ];
            volumes = [
              "/srv/prowlarr:/config"
            ];
            environment = commonEnv;
          };

          radarr = {
            image = "ghcr.io/linuxserver/radarr:latest";
            ports = [ "7878:7878" ];
            volumes = [
              "/srv/radarr:/config"
              "/media/servarr:/media"
            ];
            environment = commonEnv;
          };

          sonarr = {
            image = "ghcr.io/linuxserver/sonarr:latest";
            ports = [ "8989:8989" ];
            volumes = [
              "/srv/sonarr:/config"
              "/media/servarr:/media"
            ];
            environment = commonEnv;
          };

          byparr = {
            image = "ghcr.io/thephaseless/byparr:latest";
            ports = [ "8191:8191" ];
            environment = {
              TZ = "America/Sao_Paulo";
            };
          };

          qbittorrent = {
            image = "lscr.io/linuxserver/qbittorrent:latest";
            ports = [ "8180:8180" ];
            volumes = [
              "/srv/qbittorrent:/config"
              "/media/servarr/downloads:/media/downloads"
            ];
            environment = commonEnv // {
              WEBUI_PORT = "8180";
            };
          };

          bazarr = {
            image = "ghcr.io/linuxserver/bazarr:latest";
            ports = [ "6767:6767" ];
            volumes = [
              "/srv/bazarr:/config"
              "/media/servarr:/media"
            ];
            environment = commonEnv;
          };

          jellyseerr = {
            image = "docker.io/fallenbagel/jellyseerr:latest";
            ports = [ "5055:5055" ];
            volumes = [
              "/srv/jellyseerr:/app/config"
            ];
            environment = {
              TZ = "America/Sao_Paulo";
            };
          };

          jellyfin = {
            image = "lscr.io/linuxserver/jellyfin:latest";
            ports = [ "8096:8096" ];
            volumes = [
              "/srv/jellyfin:/config"
              "/media:/media"
            ];
            devices = [
              "/dev/dri:/dev/dri"
            ];
            environment = commonEnv;
          };

          heimdall = {
            image = "lscr.io/linuxserver/heimdall:latest";
            ports = [
              "4080:80"
              "40443:443"
            ];
            volumes = [
              "/srv/heimdall:/config"
            ];
            environment = commonEnv;
          };
        };
    };
  };
}
