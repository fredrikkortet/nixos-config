# My NixOS configurations

Here's my NixOS/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

**Highlights**:

- Multiple **NixOS configurations**, including **desktop**, **laptop**
- Fully **declarative** **self-hosted**
- **Declarative** **themes** and **wallpapers** with **nix-colors**

## Structure

- `flake.nix`: Entry point for hosts and home configurations. Also exposes a
  devshell for bootstrapping (`nix develop` or `nix-shell`).
- `lib`: A few lib functions
- `hosts`: NixOS Configurations, accessible via `nixos-rebuild --flake`.
  - `common`: Shared configurations consumed by the machine-specific ones.
    - `global`: Configurations that are globally applied to all my machines.
    - `optional`: Opt-in configurations my machines can use.
  - `desktop`: Desktop PC - 16 GB RAM, R5 3600x, Nvidia 2070 
  - `laptop`: Lenovo Yoga 7 - 16 GB RAM, R7 4700u 
- `home`: My Home-manager configuration, accessible via `home-manager --flake`
- `modules`: A few actual modules (with options).
- `overlay`: Patches and version overrides for some packages. Accessible via
  `nix build`.
- `pkgs`: It should be my custom packages. Also, accessible via `nix build`. 

## How to bootstrap

All you need is nix (any version). Run:
```
nix-shell
```

If you already have nix 2.4+, git, and have already enabled `flakes` and
`nix-command`, you can also use the non-legacy command:
```
nix develop
```

`nixos-rebuild --flake .` To build system configurations

`home-manager --flake .` To build user configurations

`nix build` (or shell or run) To build and use packages

`nix flake update` update your flake inputs

`nixos-rebuild switch --upgrade --flake ".#yourconfig"` Rebuild your system
