{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile.nvim = {
    source = ./.;
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
    nodejs_24

    # formatters
    alejandra
    stylua
    biome
    prettierd
    nodePackages.prettier
    shfmt
    rustfmt
    taplo
    typstyle

    # linters
    luajitPackages.luacheck
    ruff
    shellcheck
    cpplint
    hadolint

    # LSPs
    lua-language-server
    vscode-langservers-extracted # jsonls
    # pyright
    # basedpyright
    pyrefly
    nodePackages_latest.bash-language-server
    dockerfile-language-server
    clang-tools
    nodePackages.typescript-language-server
    ltex-ls-plus
    emmet-ls
    nil
    glsl_analyzer
    rust-analyzer
    fish-lsp
    tinymist

    # misc
    luajitPackages.jsregexp
    ghostscript
    mermaid-cli
    vscode-extensions.vadimcn.vscode-lldb.adapter
    graphviz
    python312Packages.pylatexenc
    tectonic
  ];
}
