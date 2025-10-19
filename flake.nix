{
  description = "Aaron's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    preservation.url = "github:nix-community/preservation";

    atuin.url = "github:atuinsh/atuin";
  };

  outputs = inputs: import ./hosts inputs;
}
