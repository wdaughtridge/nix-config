{
  pkgs,
  pkgs-2,
  ...
}:

{
  home.username = "wdaughtridge";
  home.homeDirectory = "/Users/wdaughtridge";

  home.stateVersion = "25.05";

  home.packages = [
    pkgs.bat
    pkgs.btop

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

    pkgs.jdk25

    pkgs.kubectl

    pkgs.lazygit

    pkgs.maven

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

    pkgs.zig
    pkgs.zls
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "flexoki_light";
      editor = {
        popup-border = "all";
      };
    };
  };

  programs.vim = {
    enable = true;
    plugins =
      (with pkgs.vimPlugins; [
        vim-sleuth
        ale
        fzf-vim
        onedark-vim
      ])
      ++ (with pkgs-2.vimPlugins; [
        zig-vim
      ]);
    extraConfig = ''
      colorscheme onedark
      set nowrap
      set backspace=indent,eol,start
      set wildmenu
      set wildmode=longest:full,full
      set ignorecase
      set smartcase
      set showcmd
      set signcolumn=yes
      set laststatus=2
      set ttyfast
      let mapleader = " "
      command! Terminal :terminal bash -l
      command! HomeManager :!home-manager switch
      nnoremap <leader>f <cmd>Files<cr>
    '';
    settings = {
      relativenumber = true;
      number = true;
    };
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
    keybindings = {
      "cmd+\\" = "launch --cwd=current";
      "cmd+enter" = "launch --cwd=current";
    };
    settings = {
      font_family = "JetBrainsMono Nerd Font Mono";
      font_size = 15;
      shell = "/Users/wdaughtridge/.nix-profile/bin/bash --login";
      editor = "hx";
      macos_option_as_alt = true;
      foreground = "#100F0F";
      background = "#FFFCF0";
      selection_foreground = "#100F0F";
      selection_background = "#CECDC3";
      cursor = "#100F0F";
      cursor_text_color = "#FFFCF0";
      active_border_color = "#D14D41";
      inactive_border_color = "#CECDC3";
      active_tab_foreground = "#100F0F";
      active_tab_background = "#CECDC3";
      inactive_tab_foreground = "#6F6E69";
      inactive_tab_background = "#E6E4D9";
      color0 = "#100F0F";
      color8 = "#6F6E69";
      color1 = "#D14D41";
      color9 = "#AF3029";
      color2 = "#879A39";
      color10 = "#66800B";
      color3 = "#D0A215";
      color11 = "#AD8301";
      color4 = "#4385BE";
      color12 = "#205EA6";
      color5 = "#CE5D97";
      color13 = "#A02F6F";
      color6 = "#3AA99F";
      color14 = "#24837B";
      color7 = "#FFFCF0";
      color15 = "#F2F0E5";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      eval "$(direnv hook bash)"
      PS1='-[\[\e[38;5;73m\]\u\[\e[0m\]:\[\e[38;5;75m\]\w\[\e[0m\]]-[\[\e[38;5;215m\]\t\[\e[0m\]]\n\\$ '
      unset DEVELOPER_DIR
      export PATH=$HOME/.nix-profile/bin:$HOME/.local/bin:$PATH
    '';
    shellAliases = {
      "ll" = "ls -la";
      "lg" = "lazygit";
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
