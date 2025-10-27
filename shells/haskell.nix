# :^) yeah it's using unstable
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.haskellPackages.ghc
    pkgs.haskellPackages.cabal-install
    pkgs.haskellPackages.hlint  # Optional: for linting Haskell code
    pkgs.haskellPackages.pretty
  ];
}
