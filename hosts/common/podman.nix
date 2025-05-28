# ~/.dots/hosts/dvpc/podman.nix
# Podman configuration for NixOS, imported from configuration.nix
{ config, pkgs, lib, ... }:

{
  # Podman package and service
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;

    # Enable automatic pruning of unused images and containers
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };

  # Configure container registries
  environment.etc = {
    "containers/registries.conf" = lib.mkForce {
      text = ''
        [registries.search]
        registries = ['docker.io', 'quay.io', 'ghcr.io']

        [registries.block]
        registries = []

        [registries.insecure]
        registries = []

        [registries.mirrors]
        [registries.mirrors."docker.io"]
        location = ["mirror.gcr.io"]
      '';
    };
  };

  # Nvidia container toolkit configuration with merged conditions
  hardware.nvidia-container-toolkit = lib.mkMerge [
    # For Sway or no desktop
    (lib.mkIf (config.my.desktop == "sway" || config.my.desktop == "none") {
      enable = false;
      suppressNvidiaDriverAssertion = true;
    })
    
    # For GNOME or Cosmic
    (lib.mkIf (config.my.desktop == "gnome" || config.my.desktop == "cosmic") {
      enable = false;
    })
    
    # Default setting (applies when no conditions above match)
    {
      enable = lib.mkDefault true;
    }
  ];

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui # Terminal UI for podman
    skopeo # Work with container images and registries
  ];
}
