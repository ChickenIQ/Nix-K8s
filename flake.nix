{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    impermanence.url = "github:nix-community/impermanence";
    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @inputs:
  let
    machineConfig = if builtins.getEnv "NIXOS_INSTALLER" == "true" then /tmp/nixos-installer/data/etc/machineconfig else /etc/machineconfig;
    listModules = path: nixpkgs.lib.filter(nixpkgs.lib.hasSuffix ".nix")(nixpkgs.lib.filesystem.listFilesRecursive path);
    specialArgs = { inherit inputs cfg listModules; };

    modules = listModules(./modules) ++ listModules(machineConfig) ++ (with inputs; [
      nixos-facter-modules.nixosModules.facter
      impermanence.nixosModules.impermanence
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
