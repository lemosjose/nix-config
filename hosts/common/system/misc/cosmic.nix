{
  pkgs,
  ...
}: {
  services.displayManager.cosmic-greeter.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "Joseph";
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-player
    cosmic-wallpapers
    cosmic-term
  ];
  
  services.desktopManager.cosmic.enable = true;
}
