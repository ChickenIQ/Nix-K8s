{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @inputs:
  let
    listModules = path: nixpkgs.lib.filter(nixpkgs.lib.hasSuffix ".nix")(nixpkgs.lib.filesystem.listFilesRecursive path);
    specialArgs = { inherit inputs cfg listModules; };

    modules = listModules(./modules) ++ (with inputs; [
      impermanence.nixosModules.impermanence
      disko.nixosModules.disko
    ]);

    cfg = {
      authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF4Waz2pv+NAEsLMT1kaFbtYjx6faBRPgHzlHdN30In"];
      stateVersion = "24.11";
    };
  in 
  {
    nixosConfigurations."master" = nixpkgs.lib.nixosSystem {
      inherit modules specialArgs;
      system = "x86_64-linux";
    };
  };
}