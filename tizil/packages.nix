{ config, lib, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      wget
      nodejs
      gcc
      #cuz nix requires it somehow
      git
      ffmpeg-full
      kexec-tools
      distrobox
      efibootmgr
      podman-compose
      texlive.combined.scheme-full
      openvpn
      libarchive
      aider-chat-full
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
      extraGroups = [ "vboxusers" "adbusers" "wheel" "libvirtd" "input" "audio" "render" "video"]; # Enable ‘sudo’ for the user.
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
	       scrcpy
	       alsa-utils
	       zeal
	       gtk3
	       tokyonight-gtk-theme
	       element-desktop
	       hexchat
	       nix-index
	       python3Full
	       asciidoctor-with-extensions
	       streamlink
      ];
      hashedPassword = "$y$j9T$ILvyeB3rSFT7yiMgx6xBh/$O3qkgsba6AcXEwtzfu2v9aWgVF.aw7F9SBoa/Lciji6";
   };

}
