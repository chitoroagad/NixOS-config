{pkgs, ...}:
with builtins; let
  _zplug = _group: _name: {
    name = "${_name}";
    src = builtins.fetchTarball "https://github.com/${_group}/${_name}/archive/master.tar.gz";
  };
  make_plugin = {
    group,
    name,
    file,
    ...
  }: {
    name = "${name}";
    src = builtins.fetchTarball "https://github.com/${group}/${name}/archive/master.tar.gz";
    file = file;
  };
in rec {
  zsh_plugins = {
    zsh-autosuggestions = _zplug "zsh-users" "zsh-autosuggestions";
    zsh-completions = _zplug "zsh-users" "zsh-completions";
    zsh-syntax-highlighting = _zplug "zsh-users" "zsh-syntax-highlighting";
    sudo = _zplug "none9632" "zsh-sudo";
    zsh-vim-mode = _zplug "softmoth" "zsh-vim-mode";
  };
  plugins_list = builtins.attrValues zsh_plugins;
}
