{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile.nvim = {
    source = ./.;
  #   # recursive = true;
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
    sshfs
    fd
    fzf
    cargo
    luajitPackages.luarocks
    lua5_1
    nodejs_23

    # formatters
    alejandra
    stylua
    stable.biome
    prettierd
    nodePackages.prettier
    shfmt
    rustfmt

    # linters
    luajitPackages.luacheck
    ruff
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
    ghostscript
    tectonic
    mermaid-cli
    vscode-extensions.vadimcn.vscode-lldb.adapter
    graphviz
  ];
}
