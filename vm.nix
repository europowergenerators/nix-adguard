# nixos-shell will automatically select this file to run within QEMU
{ pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  imports = [
    ./adguard.nix
    ./dnsmasq.nix
  ];

  virtualisation =
    {
      forwardPorts = [
        {
          from = "host";
          proto = "udp";
          host.port = 53;
          guest.port = 53;
        }
        {
          from = "host";
          host.port = 3000;
          guest.port = 3000;
        }
      ];
    };
}
