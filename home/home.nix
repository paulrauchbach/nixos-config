{ config, pkgs, lib, ... }:

let
  nodejsLts = pkgs.nodejs_22;
  nvmVersion = "v0.40.3";
in

{
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    vscode
    thunderbird
    keepassxc
    discord
    steam
    git
    ripgrep
    eza
    zsh
    oh-my-zsh
    ghostty
    codex
    claude-code
    nodejsLts
    nodePackages.pnpm
    python3
    uv
  ];

  home.sessionVariables = {
    NVM_DIR = "${config.home.homeDirectory}/.nvm";
  };

  # nvm is not packaged in this pinned nixpkgs, so Home Manager bootstraps it
  # into ~/.nvm and keeps the default Node version on the current LTS line.
  home.activation.installNvmAndNodeLts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export HOME="${config.home.homeDirectory}"
    export NVM_DIR="${config.home.homeDirectory}/.nvm"
    export PATH="${lib.makeBinPath [
      pkgs.bash
      pkgs.coreutils
      pkgs.curl
      pkgs.findutils
      pkgs.git
      pkgs.gnugrep
      pkgs.gnused
      pkgs.gawk
      pkgs.gzip
      pkgs.wget
    ]}:$PATH"

    if [ ! -s "$NVM_DIR/nvm.sh" ]; then
      installer="$(${pkgs.coreutils}/bin/mktemp)"
      trap '${pkgs.coreutils}/bin/rm -f "$installer"' EXIT

      ${pkgs.coreutils}/bin/mkdir -p "$NVM_DIR"
      ${pkgs.curl}/bin/curl -fsSL \
        "https://raw.githubusercontent.com/nvm-sh/nvm/${nvmVersion}/install.sh" \
        -o "$installer"
      PROFILE=/dev/null NVM_DIR="$NVM_DIR" ${pkgs.bash}/bin/bash "$installer"
    fi

    if [ -s "$NVM_DIR/nvm.sh" ]; then
      . "$NVM_DIR/nvm.sh"
      if nvm install --lts --latest-npm; then
        nvm alias default 'lts/*'
      else
        echo "warning: nvm could not install or update the current Node.js LTS during Home Manager activation" >&2
      fi
    fi
  '';

  programs.git = {
    enable = true;
    settings.user.name = "Paul Rauchbach";
    settings.user.email = "rauchbach.paul@gmail.com";
  };

  programs.vscode.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
    };

    initContent = ''
      export NVM_DIR="${config.home.homeDirectory}/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    '';

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "eza"
        "docker"
        "python"
      ];
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      search.default = "ddg";
      search.force = true;
      settings = {
        # restore tabs
        "browser.startup.page" = 3;

        "browser.sessionstore.resume_from_crash" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;

        # never translate
        "browser.translations.neverTranslateLanguages" = "de,en";

        "browser.tabs.warnOnClose" = false;

        # passwords / autofill
        "signon.rememberSignons" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.available" = "off";
      };
    };

    policies = {
      DisableTelemetry = true;
    };
  };
}
