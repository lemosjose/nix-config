{
  inputs, ...
}: {
imports = [
  inputs.nix-flatpak.nixosModules.nix-flatpak
];
services.flatpak.enable = true;
services.flatpak.packages = [
  "net.supertuxkart.SuperTuxKart"
  "org.telegram.desktop"
  "org.gnome.Fractal"
  "com.spotify.Client"
];

}
