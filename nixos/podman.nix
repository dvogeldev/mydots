# ~/.dots/hosts/dvpc/podman.nix
# Podman configuration for NixOS, imported from configuration.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Podman package and service
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;

    # Enable automatic pruning of unused images and containers
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = ["--all"];
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

  # Enable Nvidia support
  hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui # Terminal UI for podman
    skopeo # Work with container images and registries
  ];
}
