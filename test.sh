#!/bin/sh

nix run --experimental-features 'nix-command flakes' 'github:nix-community/disko/latest#disko-install' -- \
  --flake './#master' \
  --write-efi-boot-entries \
  --disk main /dev/vda 

