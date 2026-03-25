{ config, lib, pkgs, ... }:

let
  nodejsLts = pkgs.nodejs_22;
  nvmVersion = "v0.40.3";
in
{
  home.packages = with pkgs; [
    vscode
    nodejsLts
    nodePackages.pnpm
    python3
    uv
  ];

  home.sessionVariables = {
    NVM_DIR = "${config.home.homeDirectory}/.nvm";
  };

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

  programs.vscode.enable = true;

  programs.zsh.initContent = ''
    export NVM_DIR="${config.home.homeDirectory}/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  '';
}
