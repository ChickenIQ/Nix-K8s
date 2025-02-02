{ modulesPath, cfg, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader = {
    timeout = 0;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nix = {
    optimise.automatic = true;
    settings = {
      trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
      substituters = ["https://nix-community.cachix.org"];
      experimental-features = "nix-command flakes";
    };
  };

  system.stateVersion = cfg.stateVersion;
}