switch:
    @sudo nixos-rebuild --flake .# switch

switch-sjtu:
    @sudo nixos-rebuild --flake .# switch --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"

switch-no-sandbox:
    @sudo nixos-rebuild --flake .# switch --option sandbox false

check:
    @nix flake check

update:
    @nix flake update

gc:
    @sudo nix store gc --debug
    @sudo nix-collect-garbage --delete-old

history:
    @nix profile history --profile /nix/var/nix/profiles/system

clean:
    @sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
