{
  lib,
  pkgs,
  ...
}: {
  xdg = {
    configFile.nvim.source = ./.;
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
    # tree-sitter
    ripgrep
    sshfs
    fd
    fzf
    cargo
    luajitPackages.luarocks
    lua5_1

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
    glsl_analyzer
    rust-analyzer

    # misc
    luajitPackages.jsregexp
  ];
}
