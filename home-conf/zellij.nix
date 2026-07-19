{pkgs, ...}:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings.default_shell = "fish";
  };

  home.packages = with pkgs; [
    zellij
  ];
}
