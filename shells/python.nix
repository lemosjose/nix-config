# :^) yeah it's using unstale
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    poetry
    python315
    gcc
    glib
    libgcc
    glibc
    gnumake
    corepack
    pkg-config
    zlib
    openssl
    sqlite
    xz
    bzip2
    uv
  ];

  #solve some stuff that need gobject-instrospection, even tho i dockerize most things nowadays
  nativeBuildInputs = with pkgs; [
      pkg-config
      pango
      gobject-introspection
      gdk-pixbuf
      wrapGAppsHook4
  ];

  shellHook = ''
    export POETRY_VIRTUALENVS_IN_PROJECT=true
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
    export CPLUS_INCLUDE_PATH="${pkgs.stdenv.cc.cc.lib}/include:$CPLUS_INCLUDE_PATH"
  '';
}
