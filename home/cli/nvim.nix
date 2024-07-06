{
  lib,
  pkgs,
  ...
}: {
  xdg = {
    configFile.nvim.source = ./nvim;
    desktopEntries."nvim" = lib.mkIf pkgs.stdenv.isLinux {
      name = "NeoVim";
      comment = "Edit text files";
      icon = "nvim";
      exec = "kitty --hold ${pkgs.neovim}/bin/nvim %F";
      categories = ["TerminalEmulator"];
      terminal = false;
      mimeType = ["text/plain"];
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;
  };

  home.packages = with pkgs; [
    neovim

    git
    gcc
    gnumake
    unzip
    wget
    curl
    tree-sitter
    ripgrep
    fd
    fzf
    cargo

    nil
    lua-language-server
    stylua

    # formatters
    alejandra
    stylua
    biome
    prettierd
    nodePackages.prettier
    shfmt
    rustfmt

    # linters
    luajitPackages.luacheck
    ruff
    ruff-lsp
    shellcheck
    cpplint
    hadolint

    # LSPs
    lua-language-server
    vscode-langservers-extracted # jsonls
    pyright
    nodePackages_latest.bash-language-server
    dockerfile-language-server-nodejs
    clang-tools
    nodePackages.typescript-language-server
    ltex-ls
    emmet-ls
    nil

    # misc
    luajitPackages.jsregexp
  ];
}
