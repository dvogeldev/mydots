# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  ./core.nix
  ./boot/nix
  ./zram.nix
  ./impermanence.nix
  ./users.nix
  ./desktop/gnome.nix
  ./ssh.nix
  # You had printing commented out, uncomment if you want it:
  # ./printing.nix

  # Other modules you might want to enable from the starter config:
  # ./gaming.nix
  # ./virtualization.nix
  # ./dev.nix
  # ./containers.nix
}
