# Public flake

The public flake exposes only independently usable public modules and checks.
It does not define real host, home, network, deployment, or secret-backed
outputs.

The private Dragonix flake may consume these outputs as a pinned input, but
this repository does not depend on the private configuration.
