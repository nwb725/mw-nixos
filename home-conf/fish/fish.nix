{pkgs, config, ...}:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = if !config.isDeploy then ''
      if status is-interactive; and type -q zellij; and not set -q ZELLIJ
        zellij
      end
    '' else "";
    
    functions = {
      "fish_greeting" = {
        description = "Simply greeting displaying the date and time";
        body = ''
          set_color 5c6370
          echo " "(date '+%a %d %b — %H:%M')
          set_color normal
        '';  
      };
      "fish_prompt" = builtins.readFile ./fish_prompt.fish;
    };
  };
  home.packages = with pkgs; [
    fish
  ];
}
