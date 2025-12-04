{
  config,
  ...
}: {
programs = {
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
      vim = "nvim";
      cobrinha = "nix-shell ${config.home.homeDirectory}/nix-config/shells/python.nix --run zsh";
      pato = "nix-shell ${config.home.homeDirectory}/nix-config/shells/fullstack.nix --run zsh";
      robozinho = "nix-shell ${config.home.homeDirectory}/nix-config/shells/robo.nix --run zsh"; 
      caixinha = "nix-shell ${config.home.homeDirectory}/nix-config/shells/haskell.nix --run zsh";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "afowler";
    };
  };
};

}
