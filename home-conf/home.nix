{ config, pkgs, lib, ... }:

{
  imports = [
    ./helix.nix
    ./sway.nix
    ./kitty.nix
    ./fish/fish.nix
    ./zellij.nix
  ];
  
  home.username = "mw";
  home.homeDirectory = "/home/mw";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  xdg.portal.config.common.default = "*";
  
  programs.git = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };

  home.keyboard = {
    layout = "dk-latin1";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
	  wget
	  nerd-fonts.jetbrains-mono
    font-awesome
  ] ++ lib.optionals config.isWork [ b4 wdisplays ];
  
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
