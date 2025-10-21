{ config, lib, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     wget
     eza
     nodejs
     gcc
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
      extraGroups = [ "adbusers" "wheel" "input" "audio" "render" "polkit" "networkmanager" "video"];
      hashedPassword = "$y$j9T$ILvyeB3rSFT7yiMgx6xBh/$O3qkgsba6AcXEwtzfu2v9aWgVF.aw7F9SBoa/Lciji6";
   };

   users.users.Joseph = {
     isNormalUser= true;
     extraGroups = [ "adbusers" "wheel" "input" "audio" "render" "polkit" "networkmanager" "video"];
     hashedPassword = "$y$j9T$yYbCRUzf6ju5ExOtuFcjd/$490UtXqCPI3Qci30GwG5vQmtIo0PEZUyuOcJN5TeTAA";
   };

}
