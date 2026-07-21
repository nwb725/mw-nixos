{pkgs, ...}:
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        icons = "material-nf";
        theme = "ctp-frappe";
        blocks = [
         {
           block = "battery";
           format = " $icon $percentage ";
         }
         {
           block = "net";
           format = " $icon {$signal_strength $ssid|} ";
         }
         {
           block = "time";
           format = " $timestamp.datetime(f:'%d-%m-%Y %X') ";
           interval = 1;
         }
       ];
      };
    };
  };
  home.packages = with pkgs; [
    i3status-rust
  ];
}
