# Dragonix Public

Dragonix Public is the curated, reusable part of the Dragonix configuration
system. It is intentionally separate from the private Dragonix deployment
configuration.

This repository is a fresh publication surface, not a mirror of the private
Dragonix repository. The private repository remains the source of truth for
real hosts, users, networking, secrets, and deployment state.

## Initial seed

The first public seed contains a standalone Home Manager module for a small
`just` command-runner helper. It is deliberately small so that the public
repository can be validated independently before more modules are considered.

Use it from a Home Manager configuration:

```nix
{
  imports = [
    inputs.dragonix-public.homeManagerModules.just
  ];

  dragonix.features.programs.cli.just.enable = true;
}
```

The module installs `just` and a `j` helper. When run inside a repository with
a `justfile`, `j` executes that file from its repository root; otherwise it
delegates to `just` normally.

## Validation

```bash
nix flake check
```

## Publication status

This is pre-publication staging. The repository must receive an explicit
license decision and a final security, privacy, and provenance review before
the standalone GitHub repository is made public.
