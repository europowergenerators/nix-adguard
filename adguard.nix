# Adguard machine configuration
{ pkgs, ... }: {
  services.adguardhome =
    {
      enable = true;
      openFirewall = true;
    };

  environment.systemPackages = with pkgs; [
    # NOTE; For local debugging
    dig
  ];
}
