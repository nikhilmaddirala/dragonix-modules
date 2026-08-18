# Contributing

Contributions should improve the reusable public core without importing the
private Dragonix deployment model.

Before opening a change:

1. Keep modules independently evaluable with only the flake inputs.
2. Prefer an option or extension point over a hard-coded personal value.
3. Run `bash scripts/check-public-boundary.sh`.
4. Run `nix flake check --no-write-lock-file --all-systems`.
5. Check that new files have clear provenance and redistribution rights.

Host-specific composition, credentials, private network topology, and
deployment behavior belong in the private Dragonix repository.
