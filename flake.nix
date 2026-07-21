{
  description = "System wide flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Same version as system
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        "home" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./hosts/hardware-home.nix
          ]; 
        };
        "work" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./hosts/hardware-work.nix
          ]; 
        };
        
      };
      homeConfigurations = {
        "home" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ./home-conf/home.nix
            ./options.nix
            { enableSway = true; }
          ];
        };
        "work" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ./home-conf/home.nix
            ./options.nix
            {
              enableSway = true;
              isWork = true;
            }
          ];
        };
        "deploy" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ./home-conf/home.nix
            ./options.nix
            {
              enableSway = false;
              isDeploy = true;
            }
          ];
        };
      };
    };
}
