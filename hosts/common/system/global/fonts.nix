{
  pkgs,
  ...
}: {
   fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code 
    nerd-fonts.ubuntu 
    nerd-fonts.jetbrains-mono 
    dejavu_fonts 
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans 
    noto-fonts-emoji
    powerline-fonts
    corefonts
    powerline-symbols
  ];
}
