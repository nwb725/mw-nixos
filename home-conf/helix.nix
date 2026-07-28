{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      editor = {
        line-number = "relative";
        mouse = false;
        auto-completion = true;
        auto-format = true;
        auto-info = true;
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker.hidden = false;
      };
      keys.normal = {
        "C-g" = [
          ":write-all"
          ":insert-output lazygit >/dev/tty"
          ":redraw"
          ":reload-all"
        ];
      };
    };
    languages = {
      # Define more language servers
      language-server = {
        rust-analyzer = {
          command = "rust-analyzer";
          config = {
            cargo.allFeatures = true;
            check.command = "clippy";
          };
        };
        nil = {
          command = "nil";
        };
      };
      # List of languages
      language = [
        {
          name = "rust";
          scope = "source.rust";
          injection-regex = "rust";
          file-types = [ "rs" ];
          comment-tokens = "//";
          auto-format = true;
          indent = {
            tab-width = 4;
            unit = "    ";
          };
          formatter.command = "rustfmt";
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "nix";
          auto-format = false;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          language-servers = [ "nil" ];
        }
      ];
    };
  };

  home.packages = with pkgs; [
    rust-analyzer
    nixfmt
    nil
  ];
}
