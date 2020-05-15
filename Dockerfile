FROM nixos/nix

# Cache packages.
COPY default.nix .
RUN nix-shell --run exit
