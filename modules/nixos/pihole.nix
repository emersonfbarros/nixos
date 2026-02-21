{
  flake.modules.nixos.pihole =
    { pkgs, ... }:
    {
      virtualisation.oci-containers = {
        backend = "podman";

        containers.pihole = {
          image = "pihole/pihole:latest";
          extraOptions = [
            "--network=pihole_macvlan"
            "--ip=192.168.0.53"
            "--cap-add=SYS_TIME"
          ];
          environment = {
            TZ = "America/Maceio";
            FTLCONF_dns_upstreams = "1.1.1.1;8.8.8.8;2606:4700:4700::1111;2001:4860:4860::8888";
            FTLCONF_dns_listeningMode = "ALL";
            FTLCONF_webserver_port = "80";
          };
          volumes = [
            "/srv/pihole/etc-pihole:/etc/pihole"
          ];
        };
      };

      # Ensure the Macvlan network exists before Podman tries to start Pi-hole
      systemd.services.create-pihole-macvlan = {
        description = "Create Podman Macvlan network for Pi-hole";
        before = [ "podman-pihole.service" ];
        requiredBy = [ "podman-pihole.service" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        path = [ pkgs.podman ];
        # Checks if the network exists, if not, creates it attached to your physical interface enp2s0
        script = ''
          if ! podman network exists pihole_macvlan; then
            podman network create -d macvlan -o parent=enp2s0 --subnet=192.168.0.0/24 --gateway=192.168.0.1 pihole_macvlan
          fi
        '';
      };

      systemd.tmpfiles.rules = [
        "d /srv/pihole/etc-pihole 0755 root root -"
      ];

      # Host firewall rules are actually bypassed for Macvlan traffic, but we keep this clean
      networking.firewall = {
        allowedTCPPorts = [
          53
          80
        ];
        allowedUDPPorts = [ 53 ];
      };

      # The host itself uses public DNS safely without conflicting with the Pi-hole container
      networking.nameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
}
