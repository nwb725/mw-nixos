{pkgs, ...}:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    zellij
  ];
}
