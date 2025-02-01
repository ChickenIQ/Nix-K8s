#!/bin/sh


nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > ./modules/hardware-config.nix
sudo nixos-install --no-root-password --flake ./#master

