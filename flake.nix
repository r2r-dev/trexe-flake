{
  description = "BuildGrid trexe flake";

  inputs = {
    nixpgks.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
    buildbox-common = {
      type = "git";
      url = "https://gitlab.com/BuildGrid/buildbox/buildbox-common";
      ref = "master";
      rev = "f41c9fabaeb0f34a61f19cd217b0dcea4caa0893";
      flake = false;
    };
    trexe = {
      type = "git";
      url = "https://gitlab.com/BuildGrid/trexe";
      ref = "main";
      rev = "56047590de076f9d0039fcd7fc12bbfa4ce99a23";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
    inputs.utils.lib.eachSystem [
      "x86_64-linux"
      "i686-linux"
      "aarch64-linux"
      "x86_64-darwin"
    ] (system: let
      pkgs = import nixpkgs { inherit system;};
    in rec {
      packages = {
        buildbox-common = pkgs.callPackage ./pkgs/buildbox-common {
          src = inputs.buildbox-common;
        };
        trexe = pkgs.callPackage ./pkgs/trexe {
          inherit (packages) buildbox-common;
          src = inputs.trexe;
        };
      };
      defaultPackage = packages.trexe;
    });
}
