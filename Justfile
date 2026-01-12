[macos]
switch:
    @sudo darwin-rebuild --flake .# switch

update:
    @nix flake update

darwin:
    @sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#MacBook-Pro-13

darwin-build:
    @nix build .#darwinConfigurations.MacBook-Pro-13.system \
    --extra-experimental-features 'nix-command flakes'
