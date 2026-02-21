{
  flake.modules.nixos.pihole = {
    virtualisation.oci-containers.backend = "podman";

    virtualisation.oci-containers.containers.pihole = {
      image = "pihole/pihole:latest";
      ports = [
        "53:53/tcp"
        "53:53/udp"
        "8080:80/tcp"
      ];
      environment = {
        TZ = "America/Maceio";
        FTLCONF_dns_upstreams = "1.1.1.1;8.8.8.8;2606:4700:4700::1111;2001:4860:4860::8888";
        FTLCONF_dns_listeningMode = "ALL";
      };
      volumes = [
        "/srv/pihole/etc-pihole:/etc/pihole"
      ];
    };

    systemd.tmpfiles.rules = [
      "d /srv/pihole/etc-pihole 0755 root root -"
    ];

    networking.firewall = {
      allowedTCPPorts = [
        53
        8080
      ];
      allowedUDPPorts = [ 53 ];
    };

    networking.nameservers = [ "127.0.0.1" ];
  };
}
