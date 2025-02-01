{
  modulesPath,
  lib,
  pkgs,
  cfg,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  system.stateVersion = cfg.stateVersion;
}