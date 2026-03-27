{ config, fullName, email, lib, ... }:

let
  cfg = config.git;
in
{
  options = {
    git.enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings = {
        user.name = fullName;
        user.email = email;
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
