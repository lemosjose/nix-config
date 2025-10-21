{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    nodejs
    gcc
    git
    ffmpeg-full
    kexec-tools
    distrobox
    efibootmgr
    podman-compose
    texlive.combined.scheme-full
    slurp
    openvpn
    libarchive
    leiningen
    mako
    jdk21
    neovim
    which
    rPackages.pkgconfig 
    cairo 
    android-tools
    brightnessctl
    nodePackages.typescript
  ];

   users.users.lemos = {
     isNormalUser = true;
     extraGroups = ["adbusers" "wheel" "libvirtd" "input" "audio" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
	     gopls
	     go
	     tmux
	     pipx
	     sbcl
	     zip
	     multipath-tools 
	     openssl
	     clojure-lsp
	     dex
	     btop
	     gnome-tweaks
	     gnomeExtensions.appindicator
	     unzip
	     devbox
	     yt-dlp
       keepassxc
	     bottom
	     python312Full
	     scrcpy
	     alsa-utils
	     zeal
	     gtk3
	     tokyonight-gtk-theme
	     nix-index
	     pipenv
	     python312Packages.pkgconfig
	     asciidoctor-with-extensions
	     streamlink
     ];
     hashedPassword = "$y$j9T$ILvyeB3rSFT7yiMgx6xBh/$O3qkgsba6AcXEwtzfu2v9aWgVF.aw7F9SBoa/Lciji6";
   };

}
