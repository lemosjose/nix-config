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
    corepack
    prisma-engines
    uv
    mkcert
    inotify-tools
    elixir
    stripe-cli
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    pango
    gobject-introspection
    gdk-pixbuf
    wrapGAppsHook4
  ];

  PRISMA_CLI_BINARY_TARGETS = "debian-openssl-3.0.x"; 
  LD_LIBRARY_PATH = "${pkgs.openssl.out}/lib";


  
}
