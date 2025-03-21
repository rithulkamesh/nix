{
  description = "Code-focused Nixconf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default";
    ghostty.url = "github:ghostty-org/ghostty";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    matugen.url = "github:/InioX/Matugen";
    hyprland.url = "github:hyprwm/hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      sora = lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/sora/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "rkamesh@sora" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home/rkamesh/sora.nix
          ./home/rkamesh/nixpkgs.nix
        ];
      };
    };
  };
}
