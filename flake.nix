{
  description = "NixOS Mobile for OnePlus 6T (fajita)";

  ############################################
  # Input Dependencies
  ############################################
  inputs = {
    # Main NixOS package collection (unstable for latest mobile support)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Mobile-NixOS repository - provides mobile-specific modules and device support
    mobile-nixos = {
      url = "github:matthiasdotsh/mobile-nixos/sdm845";
      flake = false; # We import it directly, not as a flake
    };
    gnome-mobile.url = "github:chuangzhu/nixpkgs-gnome-mobile";
  };

  ############################################
  # Flake Outputs
  ############################################
  outputs = { self, nixpkgs, mobile-nixos, gnome-mobile, ... }:
    let
      system = "aarch64-linux";
    in {
      nixosConfigurations = {
        phoneputer = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import "${mobile-nixos}/lib/configuration.nix" { device = "oneplus-fajita"; })
            gnome-mobile.nixosModules.gnome-mobile
            ./configuration.nix
          ];
        };
      };
    };
} 
