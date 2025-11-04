{
imports = [
  ./firefox.nix
  ./git.nix
  ./pkgs.nix
  ./vscode.nix
  ./zsh.nix
];

services.kdeconnect.enable = true; 
}
