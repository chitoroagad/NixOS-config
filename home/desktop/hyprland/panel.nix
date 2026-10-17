# The built-in panel, shared by the static monitor rules and panel-refresh.nix
# so both build the same hl.monitor line.
{
  outputs = ["eDP-2" "eDP-1"];
  rate = {
    full = "165";
    saver = "60";
  };
  # vrr = 2 is fullscreen-only: always-on VRR (1) makes the desktop freeze
  # every few seconds on this panel since BIOS 04.05.
  monitor = output: rate: ''hl.monitor({ output = "${output}", mode = "2560x1600@${rate}", position = "0x0", scale = 1, vrr = 2 })'';
}
