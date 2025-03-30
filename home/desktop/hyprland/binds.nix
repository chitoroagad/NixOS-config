{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = let
      # hyprlock = lib.getExe inputs.hyprlock.packages.${pkgs.system}.hyprlock;
      hyprlock = lib.getExe pkgs.hyprlock;
    in {
      "$mainMod" = "SUPER";

      bindm = [
        # Move/Resize windows with mainMod + LMB/RMB and dragging
        "$mainMod,mouse:272,movewindow"
        "$mainMod,mouse:273,resizewindow"
        "$mainMod, Z, movewindow"
      ];

      bind = [
        # Workspace movement
        "$mainMod, J, workspace, -1"
        "$mainMod, K, workspace, +1"

        # Move focus with mainMod + arrow keys
        "$mainMod, N, movefocus, l"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Lock Screen
        "$mainMod, L, exec, ${hyprlock}"

        # Misc
        "$mainMod, V, togglefloating,"
        "$mainMod SHIFT, J, togglesplit,"
        "$mainMod, F11, fullscreen,"
      ];
    };
  };
}
