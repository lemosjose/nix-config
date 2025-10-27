# :^) yeah it's using unstable
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {} }:

pkgs.mkShell {
  name = "fullstack-dev-shell";

  buildInputs = with pkgs; [
    nodejs
    python315 
    git
    curl
    wget
    openssl
    gcc
    glib
    libgcc
    glibc
    gnumake
    pkg-config
    typescript
    eslint
    prettier
    poetry
    corepack
    uv
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    pango
    gobject-introspection
    gdk-pixbuf
    wrapGAppsHook4
  ];


  
}
