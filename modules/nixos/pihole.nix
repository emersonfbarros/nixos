{
  flake.modules.nixos.pihole = {
    virtualisation.oci-containers = {
      backend = "podman";

      containers.pihole = {
        image = "pihole/pihole:latest";
        extraOptions = [
          "--network=host"
        ];
        environment = {
          TZ = "America/Maceio";
          FTLCONF_dns_upstreams = "1.1.1.1;8.8.8.8;2606:4700:4700::1111;2001:4860:4860::8888";
          FTLCONF_dns_listeningMode = "ALL";
          FTLCONF_webserver_port = "8081";
        };
        volumes = [
          "/srv/pihole/etc-pihole:/etc/pihole"
        ];
      };
    };

    systemd.tmpfiles.rules = [
      "d /srv/pihole/etc-pihole 0755 root root -"
    ];

    networking.firewall = {
      allowedTCPPorts = [
        53
        8081
      ];
      allowedUDPPorts = [ 53 ];
    };

    networking.nameservers = [
      "127.0.0.1"
      "1.1.1.1"
    ];
  };
}
