{
  description = "My NIXOS config's based on ghUser Misterio77";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    stylix,
    home-manager,
    ...
  } @ inputs:
  let
    inherit (self) outputs;

    themePolarity = "dark";
    # themePolarity = "light";

    themeConfig = {
      polarity = themePolarity;
      dark = {
        base16 = "kanagawa-dragon";
	wallpaper = ./wallpapers/sphere-dots.jpg;
      };
      light = {
        base16 = "solarized-light";
	wallpaper = ./wallpapers/light-default.jpg;
      };
      # derived values
      base16 = builtins.getAttr themePolarity {
        dark = themeConfig.dark.base16;
	light = themeConfig.light.base16;
      };
      wallpaper = builtins.getAttr themePolarity {
        dark = themeConfig.dark.wallpaper;
	light = themeConfig.light.wallpaper;
      };
    };

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      dvpc = nixpkgs.lib.nixosSystem {
        specialArgs = {
	  inherit inputs outputs themeConfig;
	};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/dvpc/configuration.nix
	  inputs.stylix.nixosModules.stylix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "david@dvpc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
	  inherit inputs outputs themeConfig;
	};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
	  inputs.stylix.homeModules.stylix
        ];
      };
    };
    # Add this section for development shells
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      unstablePkgs = nixpkgs-unstable.legacyPackages.${system}; # Access unstable packages
    in {
      # The 'default' development shell when you run 'nix develop'
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          fzf
	  cmake
          lazygit
	  libtool
          eza
          wl-clipboard
          fish
          fastfetch
          # Add any other packages you want in your default development shell here
          # For example, from unstable:
          # unstablePkgs.htop
        ];

        # Environment variables specific to this shell (optional)
        shellHook = ''
          echo "Entering a flake-powered development shell!"
        '';
      };

      # You can define other named development shells if needed:
      # myOtherShell = pkgs.mkShell {
      #   buildInputs = with pkgs; [
      #     git
      #     nodejs
      #   ];
      # };
    });
  };
}
