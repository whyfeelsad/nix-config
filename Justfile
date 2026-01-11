[macos]
switch:
	@sudo darwin-rebuild --flake .# switch

update:
	@nix flake update
