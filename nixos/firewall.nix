{config, ...}: {
  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22];
    # Restrict to local network
    extraCommands = ''
      iptables -A INPUT -p tcp --dport 22 -s 192.168.1.210/16 -j ACCEPT
      iptables -A INPUT -p tcp --dport 22 -j DROP
    '';
  };
}
