{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = [
    pkgs.hello
    pkgs.cargo
    pkgs.rustc
    pkgs.lazygit
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals = {
      localleader = ",";
      mapleader = " ";
    };
    colorschemes.everforest.enable = true;
    performance.byteCompileLua.enable = true;
    plugins.web-devicons.enable = true;
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>f" = "git_files";
        "<leader>/" = "live_grep";
      };
    };
    plugins.lsp = {
      enable = true;
      servers = {
        rust_analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
        };
      };
    };
    plugins.sleuth.enable = true;
    plugins.fugitive.enable = true;
    plugins.treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        toml
        vim
        vimdoc
        xml
        yaml
	rust
      ];
    };
  };

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    aliases = {
      ci = "commit";
      co = "checkout";
      st = "status";
    };
    userName = "wdaughtridge";
    userEmail = "wdaughtridge@gmail.com";
    extraConfig = {
      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
  };

  programs.home-manager.enable = true;
}
