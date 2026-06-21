#!/usr/bin/env bash
cd ~/nixos
# get the latest packages
nix flake update
# build the system
nixos-rebuild build --flake .
# show the diff
nvd diff /run/current-system result

# then do 
# sudo nixos-rebuild switch --flake .
