# NixOS Config

This repository contains my flake-based NixOS configuration.

The setup is split into reusable modules, host-specific machine definitions, and Home Manager user configuration so it can grow from one desktop to multiple machines.

## Structure

- `flake.nix`
  - Entry point for all hosts.
  - Defines `nixosConfigurations` and wires in Home Manager.

- `hosts/`
  - One directory per machine.
  - `hosts/nixos/` is the current desktop.
  - `hosts/laptop/` is a scaffold for a future laptop.
  - Each host imports shared modules plus host-specific hardware.

- `modules/nixos/`
  - Reusable NixOS modules.
  - `base.nix` contains shared system defaults.
  - `desktops/` contains desktop-environment-specific modules.
  - `hardware/` contains hardware-specific modules like NVIDIA.
  - `security/` contains things like Lanzaboote.
  - `users/` contains reusable user definitions.

- `home/`
  - Home Manager configuration.
  - `common.nix` contains shared user setup.
  - `dev.nix` contains development tooling.
  - `desktops/` contains desktop-environment-specific user config.
  - `profiles/` contains optional package sets such as desktop-only apps.
  - `hosts/` contains host-specific Home Manager config, such as monitor layouts.

## Current Host Setup

The active desktop host is `nixos`.

Its config is assembled from:

- `hosts/nixos/default.nix`
- `modules/nixos/base.nix`
- `modules/nixos/desktops/gnome.nix`
- `modules/nixos/hardware/nvidia.nix`
- `modules/nixos/security/lanzaboote.nix`
- `modules/nixos/users/main-user.nix`
- `home/common.nix`
- `home/dev.nix`
- `home/desktops/gnome.nix`
- `home/hosts/nixos/monitors.nix`
- `home/profiles/desktop.nix`

## Rebuild

Use the Home Manager alias:

- `rebuild`

Or run directly:

- `sudo nixos-rebuild switch --flake 'path:/home/paul/nixos-config#nixos'`

The `path:` prefix is intentional. It makes rebuilds work even when there are uncommitted files in the repo.

## Adding a Laptop

The repo already includes a scaffold at `hosts/laptop/default.nix`.

To enable it:

1. Generate a hardware config for the laptop and place it at `hosts/laptop/hardware-configuration.nix`.
2. Uncomment the `laptop` host in `flake.nix`.
3. Add any laptop-only modules, such as `modules/nixos/laptop/power.nix`.
4. Add any laptop-only Home Manager config under `home/hosts/laptop/` or `home/profiles/laptop.nix`.

## Desktop Environments

Desktop-environment-specific config should live in:

- `modules/nixos/desktops/`
- `home/desktops/`

That makes it easy to swap GNOME for another desktop environment later without changing the shared base config.
