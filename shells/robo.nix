{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { config.allowUnfree = true; } }:
pkgs.mkShell {
  buildInputs = [
    pkgs.androidStudioPackages.stable
    pkgs.nodejs_20
    pkgs.jdk17
    pkgs.watchman
    pkgs.unzip
    pkgs.git
    pkgs.flutter
    pkgs.cmake
    pkgs.ninja
    pkgs.clang
    pkgs.pkg-config
    pkgs.gtk3
    pkgs.xz
    pkgs.pcre
  ];

  shellHook = ''
    export JAVA_HOME=${pkgs.jdk17}
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
  '';
}
