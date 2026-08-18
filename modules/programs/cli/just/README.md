# Just helper

This Home Manager module installs `just` and a `j` wrapper that automatically
uses the repository-local `justfile` when one is available.

```nix
{
  imports = [
    inputs.dragonix-public.homeManagerModules.just
  ];

  dragonix.features.programs.cli.just.enable = true;
}
```
