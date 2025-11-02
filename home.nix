{ _config, pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  home.username = "wdaughtridge";
  home.homeDirectory = "/Users/wdaughtridge";

  home.stateVersion = "25.05";

  home.packages = [
    pkgs.nil
    pkgs.bat
    pkgs.curl
    pkgs.fzf
    pkgs.ripgrep
    pkgs.git
    pkgs.gh
    pkgs.tree-sitter
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.lazygit.enable = true;

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      localleader = " ";
    };

    opts = {
      winborder = "double";
      signcolumn = "yes:1";
      number = true;
      relativenumber = true;
    };

    colorschemes.nord.enable = true;

    plugins = {
      lsp.enable = true;
      sleuth.enable = true;
      fugitive.enable = true;
      web-devicons.enable = true;
      transparent.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "git_files";
          "<leader>a" = "find_files";
          "<leader>/" = "live_grep";
        };
      };

      treesitter = {
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
          typescript
          javascript
        ];
      };
    };

    lsp = {
      servers = {
        nil_ls.enable = true;
        rust_analyzer.enable = true;
      };
    };

    performance = {
      byteCompileLua.enable = true;
      combinePlugins.enable = true;
    };
  };

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

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
