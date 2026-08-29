# Dragonix Modules

Reusable Nix modules for Home Manager, NixOS, and nix-darwin.

Dragonix Modules provides composable capabilities and profiles for building a
practical shell, terminal, development, and desktop environment with Nix.

## Features

- A complete `homeManagerModules.default` entry point.
- `minimal`, `developer`, and `terminal` profiles.
- Composable modules for Git, fd, jq, ripgrep, bat, eza, fzf, zoxide, direnv,
  Starship, tealdeer, `just`, Git delta, Nix tooling, and shell quality tools.
- Portable tmux, Zellij, and WezTerm modules with extension points.
- Public CLI, terminal, IDE, AI, browsing, and desktop capabilities.
- Extension points for packages, aliases, settings, and environment values.
- Cross-platform flake checks and standalone example compositions.
- Provenance documentation for the published module set.

Every leaf capability is opt-in. Package-backed capabilities install their
corresponding `nixpkgs` package on supported systems and fail evaluation with
an actionable error when a package is unavailable. Enabled capabilities can
also expose a namespaced `dx-*` command alias when the selected package
publishes an executable. Configuration-bearing capabilities can write a small
portable settings file, and native leaves use Home Manager's program modules.

The primary integration surface is Home Manager. Additional NixOS and
nix-darwin module classes are included where documented in the module catalog.

## Quick start

Add Dragonix Modules to a flake:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dragonix-modules.url = "github:OWNER/dragonix-modules";
  };

  outputs = { home-manager, dragonix-modules, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      homeConfigurations.alice =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            dragonix-modules.homeManagerModules.default

            {
              home.username = "alice";
              home.homeDirectory = "/home/alice";
              home.stateVersion = "25.11";

              dragonix.profiles.developer.enable = true;
            }
          ];
        };
    };
}
```

Replace the example username, home directory, system, and
`home.stateVersion` with values appropriate for your machine. Apply the
configuration with:

```bash
home-manager switch --flake .#alice
```

You can compose individual modules instead of using a profile. See the module
catalog for the available options and recommended combinations.

## Profiles

Profiles provide convenient starting points:

- `dragonix.profiles.minimal.enable`
- `dragonix.profiles.developer.enable`
- `dragonix.profiles.terminal.enable`

Profiles are compositions. Individual capabilities can be enabled separately
when you need more control over the resulting configuration.

## Documentation

- [Module catalog](docs/module-catalog.md)
- [Module tree](modules/README.md)
- [Flake integration](flake/README.md)
- [Module manifest](docs/module-manifest.tsv)
- [Public boundary](docs/public-boundary.md)
- [Provenance and redistribution](docs/provenance-and-redistribution.md)
- [Contributing](CONTRIBUTING.md)

## Compatibility

The flake pins its Nixpkgs and Home Manager inputs in `flake.lock`.

The supported validation matrix is defined by the flake and checked with:

```bash
nix flake check --all-systems
```

Dragonix Modules requires Nix with flakes enabled and is intended for use with
Home Manager. Refer to the module documentation for platform-specific
limitations and integration details.

## Development

Clone the repository and run the checks:

```bash
git clone https://github.com/OWNER/dragonix-modules.git
cd dragonix-modules

nix flake check --all-systems
bash scripts/check-public-boundary.sh
```

The boundary check verifies that the repository contains only the intended
public module set. It rejects known private host identifiers,
credential-shaped values, generated state, and incomplete provenance metadata.

## Security

Please report security vulnerabilities privately through GitHub Security
Advisories for this repository. Do not disclose sensitive infrastructure
details or credentials in public issues.

## License

Dragonix Modules is licensed under the [MIT License](LICENSE).

The repository contains module code and configuration interfaces. Licenses for
upstream packages referenced by these modules remain with their respective
projects.
