# Personal NixOS config, including dotfiles using Home-Manager

## Structure

### OS

All OS files in `nixos` directory, separated by feature

### Home

All dotfiles and configs in `home` directory, separated by cli and gui applications, again separated by feature.
Some notable inclusions:

- Neovim
- Tmux
- Hyprland
- Waybar

### Extra

Some extra directories are included, such as `modules` for adding your own modules and packages.

## Running

You can run this config by enabling flakes in nix and copying this repo into `/etc/nixos/` and running `nixos-rebuild switch`.
