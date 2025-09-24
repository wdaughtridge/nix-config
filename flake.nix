{
  description = "Home Manager configuration of wdaughtridge";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      nixvim = import (builtins.fetchGit {
        url = "https://github.com/nix-community/nixvim";
        ref = "main";
        rev = "0c15f88f1fc01c8799c5ce2a432fadc47f20e307";
      });
    in
    {
      homeConfigurations."wdaughtridge" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            imports = [
              nixvim.homeModules.nixvim
            ];

            home.username = "wdaughtridge";
            home.homeDirectory = "/Users/wdaughtridge";

            home.stateVersion = "25.05";

            home.packages = [
              pkgs.ripgrep
              pkgs.nerd-fonts._0xproto
              pkgs.git
              pkgs.bash
              pkgs.gitui
            ];

            home.file = {};

            home.sessionVariables = {
              EDITOR = "nvim";
              VISUAL = "nvim";
            };

            nix = {
              package = pkgs.nix;
              settings.experimental-features = [ "nix-command" "flakes" ];
            };

            programs.nixvim = {
              enable = true;
              performance.byteCompileLua.enable = true;
              colorschemes.everforest.enable = true;
              globals.mapleader = " ";
              viAlias = true;
              vimAlias = true;
              opts = {
                number = true;
                relativenumber = true;
                signcolumn = "yes";
                termguicolors = true;
                mouse = "a";
                ignorecase = true;
                smartcase = true;
                encoding = "utf-8";
                fileencoding = "utf-8";
                cursorline = true;
                ruler = true;
                scrolloff = 8;
              };
              keymaps = [
                {
                  key = "<leader>f";
                  action = "<cmd>Telescope find_files<CR>";
                }
                {
                  key = "<leader>/";
                  action = "<cmd>Telescope live_grep<CR>";
                }
              ];
              extraConfigLua = ''
                vim.diagnostic.config({
                  virtual_lines = {
                    current_line = true
                  }
                })
              '';
              plugins = {
                lualine.enable = true;
                sleuth.enable = true;
                fugitive.enable = true;
                web-devicons.enable = true;
                telescope = {
                  enable = true;
                };
                lsp = {
                  enable = true;
                  servers = {
                    ts_ls.enable = true;
                    yamlls.enable = true;
                    nixd.enable = true;
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
                    typescript
                    javascript
                  ];
                };
              };
            };

            programs.home-manager.enable = true;
          }
        ];
      };
    };
}
