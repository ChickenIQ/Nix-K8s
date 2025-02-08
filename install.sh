#!/bin/sh

rm -r /tmp/nixos-installer/ > /dev/null 2>&1
mkdir -p /tmp/nixos-installer/data/etc/machineconfig

export NIXOS_INSTALLER=true
nix run github:nix-community/nixos-anywhere -- --option pure-eval false --extra-files /tmp/nixos-installer \
  --generate-hardware-config nixos-generate-config /tmp/nixos-installer/data/etc/machineconfig/hardware-configuration.nix \
  --flake .#nixos --target-host root@192.168.122.146 