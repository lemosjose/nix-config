{ pkgs, ... }:

#TODO: manage specialisation and Travis user correctly, it's currently messy
{
  programs = {
    git = {
      enable = true;
      userEmail = "devlemosjose@gmail.com";
      userName = "lemosjose";
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        enterDev = "nix-shell nix/shell.nix";
        update = "sudo nixos-rebuild switch --upgrade";
        clean = "sudo nix-collect-garbage -d";
        cd = "z";
        ls = "eza";
      };
      history = {
        path = "/home/lemos/.zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "afowler";
      };
    };
   };
}
