{
imports = [
  ./firefox.nix
  ./git.nix
  ./pkgs.nix
  ./podman.nix
  ./vscode.nix
  ./zsh.nix
];

services.kdeconnect.enable = true; 
}
