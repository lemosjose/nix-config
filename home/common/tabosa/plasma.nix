#generate through rc2nix for backup
{
  config,
  inputs,
  ...
}:
{
  imports  = [
    inputs.plasma-manager.homeModules.plasma-manager
  ]; 
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "${config.home.homeDirectory}/Wallpaper/landscape";
    };

    panels = [
      {
        location = "left";
        widgets = [
          {
            kickoff = {
              sortAlphabetically = true;
              icon = "nix-snowflake-white";
            };
          }
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
              ];
            };
          }

          {
            digitalClock = {
              calendar.firstDayOfWeek = "sunday";
              time.format = "12h";
            };
          }
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.battery"
                "org.kde.plasma.bluetooth"
              ];
              hidden = [
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }
        ];
        height = 20;
        hiding = "autohide";
      }
    
    ];

    input.keyboard.layouts = [
      {
        layout = "br";
      }
      {
        layout = "us";
      }
    ];

    input.keyboard.options = ["ctrl:swapcaps"]; 
    
  };
}


