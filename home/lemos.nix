# This header is crucial. It turns the file into a function
# that receives 'pkgs' and other inputs.
{ pkgs, ... }:

{
  # Your program configurations
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    vscode = { 
        enable = true; 
	package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib pkg-config ]);
    };

    git = {
      enable = true;
      userEmail = "devlemosjose@gmail.com";
      userName = "lemosjose";
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

  # Your user packages and home settings
  home = {
    # It's good practice to keep this updated to your NixOS version
    stateVersion = "25.05";

    packages = with pkgs; [
      libreoffice-fresh
      mupdf
      discord
      calibre
      gnome-pomodoro
      google-chrome
      thunderbird
      kdePackages.ark
      mpv
      kdePackages.okular
      vlc
      zed-editor
      ptyxis
      postman
      amberol
      firefox
      chromium
      pavucontrol
      spotify
      gimp
      emacs-pgtk
      gnome-tweaks
    ];
  };
}
