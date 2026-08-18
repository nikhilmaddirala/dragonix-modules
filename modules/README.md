# Public modules

Public modules must be independently usable and must not import private
Dragonix paths. Host names, user identities, real domains, infrastructure
topology, credentials, and private deployment policy belong in the private
Dragonix configuration.

The public module API should expose behavior and options. Private Dragonix may
compose these modules with host- and user-specific values later.
