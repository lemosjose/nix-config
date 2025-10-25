{ pkgs,
  ...
}:{

qt = {
  enable = true;
  platformTheme.name = "adwaita";
  #ensure qt6 just in case
  style.package = pkgs.adwaita-qt6;
  style.name = "adwaita-dark";
};

dconf.settings = {
  "org/gnome/desktop/input-sources" = {
    xkb-options = [ "ctrl:swapcaps" "compose:ralt" ];
  };

  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Super>t";
    command = "ghostty";
    name = "terminal";
  };

  "org/gnome/shell" = {
    enabled-extensions = [ "gsconnect@andyholmes.github.io" ];
    favorite-apps = [ "org.gnome.Nautilus.desktop" "org.keepassxc.KeePassXC.desktop" "code.desktop" "firefox.desktop" "emacs.desktop" "org.telegram.desktop.desktop" "org.gnome.Lollypop.desktop" "vivaldi-stable.desktop" "com.spotify.Client.desktop" ];
    last-selected-power-profile = "performance";
    welcome-dialog-last-shown-version = "48.2";
  };

  "org/gnome/settings-daemon/plugins/color" = {
    night-light-enabled = true;
    night-light-schedule-automatic = false;
    night-light-schedule-from = 0.0;
    night-light-schedule-to = 23.983333333333334;
    night-light-temperature = 1937;
  };

  
  "org/gnome/shell/keybindings" = {
    screenshot = [ "<Super>p" ];
    screenshot-window = [ "<Alt><Super>p" ];
    show-screenshot-ui = [ "<Shift><Super>p" ];
  };

  "org/gnome/desktop/wm/keybindings" = {
    switch-to-workspace-left = [ "<Control><Super>Left" ];
    switch-to-workspace-right = [ "<Control><Super>Right" ];
  };
};

}
