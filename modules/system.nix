{ modulesPath, cfg, inputs, ... }:
{
  boot.loader = {
    timeout = 0;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nix = {
    optimise.automatic = true;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      auto-optimise-store = true;
      trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
      substituters = ["https://nix-community.cachix.org"];
      experimental-features = "nix-command flakes";
    };
  };

  environment.variables.FLAKE = cfg.flake;

  programs = {
    nix-index-database.comma.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };
  };

  system.stateVersion = cfg.stateVersion;
}