#!/bin/sh


nixos-generate-config --show-hardware-config --no-filesystems --root /mnt
sudo nixos-install --no-root-password --flake ./#master

