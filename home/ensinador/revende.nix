{
  pkgs,
  config,
  inputs,
  ...
}:
{

imports = [
  ../common/zsh.nix
];

programs = {
  zsh = {
    history = {
      path = "/home/ensinador/.zsh/history";
    };
  };
};

home = {
  stateVersion = "25.05";

  packages = with pkgs; [
    eza
    neovim
  ];

  homeDirectory = "/home/ensinador";
};
}
