{
  pkgs,
  pkgs-2,
  helix,
  zig,
  ...
}:

{
  nixpkgs = {
    overlays = [
      helix.overlays.default
      zig.overlays.default
    ] ;   
  };

  home.username = "wdaughtridge";
  home.homeDirectory = "/Users/wdaughtridge";

  home.stateVersion = "25.05";

  home.packages = [
    pkgs.babashka
    pkgs.bat
    pkgs.btop

    pkgs.clj-kondo
    pkgs.clojure
    pkgs.clojure-lsp
    pkgs.cmake
    pkgs.curl

    pkgs-2.deno
    pkgs.direnv

    pkgs-2.erlang

    pkgs.fzf

    pkgs.gh
    pkgs.git
    pkgs-2.gleam
    pkgs.go
    pkgs.gopls
    pkgs.gum

    pkgs.jdk25

    pkgs.kubectl

    pkgs.lazygit

    pkgs.maven
    pkgs.minikube

    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.open-dyslexic
    pkgs.nil
    pkgs.nixd
    pkgs.nodejs

    pkgs.rebar3
    pkgs.ripgrep
    pkgs.rustup

    pkgs.scala

    pkgs.tree-sitter
    pkgs.ty

    pkgs.uv

    pkgs.wget

    pkgs.zigpkgs.master
    pkgs.zls
  ];

  programs.helix = {
    enable = true;
    settings = {
      # theme = "flexoki_light";
      theme = "wolf-alabaster-dark";
      editor = {
        popup-border = "all";
      };
    };
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
    keybindings = {
      "cmd+\\" = "launch --cwd=current";
      "cmd+enter" = "launch --cwd=current";
    };
    # themeFile = "flexoki_light";
    themeFile = "alabaster_dark";
    settings = {
      font_family = "JetBrainsMono Nerd Font Mono";
      font_size = 15;
      shell = "/Users/wdaughtridge/.nix-profile/bin/bash --login";
      editor = "hx";
      macos_option_as_alt = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      eval "$(direnv hook bash)"
      PS1='-[\[\e[38;5;73m\]\u\[\e[0m\]:\[\e[38;5;75m\]\w\[\e[0m\]]-[\[\e[38;5;215m\]\t\[\e[0m\]]\n\\$ '
      unset DEVELOPER_DIR
      source /Users/wdaughtridge/.ghcup/env
      export PATH=$HOME/.nix-profile/bin:$HOME/.juliaup/bin:$HOME/.local/bin:$PATH
      eval $(opam env)
    '';
    shellAliases = {
      "ll" = "ls -la";
      "lg" = "lazygit";
      "haskell-language-server" = "hls";
    };
  };

  home.file = { };

  home.sessionVariables = { };

  programs.git = {
    enable = true;
    settings = {
      alias = {
        ci = "commit";
        co = "checkout";
        st = "status";
      };
      user = {
        name = "wdaughtridge";
        email = "wdaughtridge@gmail.com";
      };
    };
  };

  programs.home-manager.enable = true;
}
