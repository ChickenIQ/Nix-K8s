{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
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
    disko.nixosModules.disko
  ]);

  cfg = {
    authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF4Waz2pv+NAEsLMT1kaFbtYjx6faBRPgHzlHdN30In"];
    stateVersion = "24.11";
  };
  in {
    nixosConfigurations.generic = nixpkgs.lib.nixosSystem {
      inherit modules specialArgs;
    };
  };
}
