# Dnqmasq machine configuration
{ pkgs, ... }: {
  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
  };

  # REF; https://gist.github.com/m13253/c427f6825e938101189d
  services.dnsmasq.settings = {
    port = 5353;

    # Forward DNS queries to malware blocking DNS upstream
    server = [
      "/AD.europowergenerators.com/10.0.0.100"
      "1.1.1.3"
      "1.0.0.3"
    ];

    # Log DHCP transactions, only for for troubleshooting
    log-dhcp = true;

    # Allow all hosts within the subnet to have a domain.
    domain = "clients.ebst.e-powerinternational.com,10.0.0.0/8";

    # DNS global options
    domain-needed = true;
    bogus-priv = true;
    no-hosts = true;
    # TEST static address
    address = "/ping.clients.ebst.e-powerinternational.com/10.99.99.15";

    dhcp-range = [
      "set:VLAN1,10.1.0.10,10.1.0.255,255.255.255.0,30m"
      "set:VLAN2,10.2.0.10,10.2.0.255,255.255.255.0,30m"
    ];

    dhcp-option = [
      # DHCP global options
      # dhcp-option="option:dns-server,10.1.0.2,10.1.0.3";
      # The following DHCP options set up dnsmasq in the same way as is specified
      # for the ISC dhcpcd in
      # http://www.samba.org/samba/ftp/docs/textdocs/DHCP-Server-Configuration.txt
      # adapted for a typical dnsmasq installation where the host running
      # dnsmasq is also the host running samba.
      # you may want to uncomment some or all of them if you use
      # Windows clients and Samba.
      #dhcp-option=19,0           # option ip-forwarding off
      #dhcp-option=44,0.0.0.0     # set netbios-over-TCP/IP nameserver(s) aka WINS server(s)
      #dhcp-option=45,0.0.0.0     # netbios datagram distribution server
      #dhcp-option=46,8           # netbios node type
      # Send microsoft-specific option to tell windows to release the DHCP lease
      # when it shuts down. Note the "i" flag, to tell dnsmasq to send the
      # value as a four-byte integer - that's what microsoft wants. See
      # http://technet2.microsoft.com/WindowsServer/en/library/a70f1bb7-d2d4-49f0-96d6-4b7414ecfaae1033.mspx?mfr=true
      #dhcp-option=vendor:MSFT,2,1i

      "tag:VLAN1,option:router,10.1.0.1"
      "tag:VLAN2,option:router,10.2.0.1"
    ];
  };
}
