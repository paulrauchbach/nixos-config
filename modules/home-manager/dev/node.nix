{ config, lib, pkgs, ... }:

let
  nodejsLts = pkgs.nodejs_22;
  homeDir = config.home.homeDirectory;
  nvmDir = "${homeDir}/.nvm";
  nvmVersion = "v0.40.3";
  activationPath = lib.makeBinPath [
    pkgs.bash
    pkgs.coreutils
    pkgs.curl
    pkgs.findutils
    pkgs.git
    pkgs.gawk
    pkgs.gnugrep
    pkgs.gnused
    pkgs.gzip
    pkgs.wget
  ];
in
{
  home.packages = [
    nodejsLts
    pkgs.nodePackages.pnpm
  ];

  home.sessionVariables.NVM_DIR = nvmDir;

  home.activation.installNvmAndNodeLts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export HOME="${homeDir}"
    export NVM_DIR="${nvmDir}"
    export PATH="${activationPath}:$PATH"

    if [ ! -s "$NVM_DIR/nvm.sh" ]; then
      installer="$(${pkgs.coreutils}/bin/mktemp)"
      trap '${pkgs.coreutils}/bin/rm -f "$installer"' EXIT

      ${pkgs.coreutils}/bin/mkdir -p "$NVM_DIR"

      if ${pkgs.curl}/bin/curl -fsSL \
        "https://raw.githubusercontent.com/nvm-sh/nvm/${nvmVersion}/install.sh" \
        -o "$installer"; then
        PROFILE=/dev/null NVM_DIR="$NVM_DIR" ${pkgs.bash}/bin/bash "$installer"
      else
        echo "warning: failed to download nvm ${nvmVersion}" >&2
      fi
    fi

    if [ -s "$NVM_DIR/nvm.sh" ]; then
      . "$NVM_DIR/nvm.sh"

      if nvm install --lts --latest-npm; then
        default_node="$(nvm version lts/*)"

        if [ "$default_node" != "N/A" ]; then
          nvm alias default "$default_node"
          nvm use --silent "$default_node"
        else
          echo "warning: nvm could not resolve an LTS Node.js version for the default alias" >&2
        fi
      else
        echo "warning: nvm could not install or update the current Node.js LTS during Home Manager activation" >&2
      fi
    fi
  '';

  programs.zsh.initContent = ''
    export NVM_DIR="${nvmDir}"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
      . "$NVM_DIR/nvm.sh"
      nvm use --silent default >/dev/null 2>&1
    fi
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  '';
}
