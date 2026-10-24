# Workarounds for upstream nixpkgs breakage. Delete entries once nixpkgs catches
# up; overriding a package costs cache hits for it and everything downstream.
{ lib, ... }: let
  # 2026-10-24: 1/1679 tests fails, reached via calibre -> piper-tts.
  pythonTestSkips = [ "pyopenjtalk-plus" ];

  testSkips = [ ];

  noChecks = drv: drv.overrideAttrs (_: {
    doCheck = false;
    doInstallCheck = false;
  });
in {
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (pyfinal: pyprev: lib.genAttrs pythonTestSkips (n: noChecks pyprev.${n}))
      ];
    })

    (final: prev: lib.genAttrs testSkips (n: noChecks prev.${n}))
  ];
}
