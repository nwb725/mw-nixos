{ config, pkgs, lib, ... }:

{
  imports = [
    ./helix.nix
    ./sway.nix
  ];
  
  home.username = "mw";
  home.homeDirectory = "/home/mw";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  xdg.portal.config.common.default = "*";
  
  programs.git = {
    enable = true;
  };

  home.keyboard = {
    layout = "dk-latin1";
  };

  programs.discord.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # helix
	  zellij
	  wget
	  kitty
	  fish

	  nerd-fonts.jetbrains-mono
    font-awesome
  ] ++ lib.optionals config.isWork [ b4 ];
  
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
