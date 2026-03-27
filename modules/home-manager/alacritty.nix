{ pkgs, ... }:

{
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
        opacity = 0.95;
        padding = {
          x = 12;
          y = 12;
        };
      };

      font = {
        normal = {
          family = "CaskaydiaMono Nerd Font";
          style = "Regular";
        };

        size = 12.0;
      };
    };
  };
}
