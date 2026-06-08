{lib, ...}: {
  wayland.windowManager.hyprland = {
    settings = let
      inherit (lib.generators) mkLuaInline;
      dsp = expr: mkLuaInline "hl.dsp.${expr}";

      # mainMod + key -> dispatcher
      bind = keys: dispatcher: {_args = [keys dispatcher];};
      # mouse bind (formerly bindm): hl.bind(keys, dispatcher, { mouse = true })
      mouseBind = keys: dispatcher: {
        _args = [keys dispatcher {mouse = true;}];
      };

      # Switch / move-to workspace 1..10 (key 0 == workspace 10)
      workspaceBinds = lib.concatMap (i: let
        key =
          if i == 10
          then "0"
          else toString i;
      in [
        (bind "SUPER + ${key}" (dsp "focus({ workspace = ${toString i} })"))
        (bind "SUPER + SHIFT + ${key}" (dsp "window.move({ workspace = ${toString i} })"))
      ]) (lib.range 1 10);
    in {
      bind =
        [
          # Workspace movement (relative)
          (bind "SUPER + J" (dsp ''focus({ workspace = "-1" })''))
          (bind "SUPER + K" (dsp ''focus({ workspace = "+1" })''))

          # Move focus with mainMod + arrow keys
          (bind "SUPER + N" (dsp ''focus({ direction = "left" })''))
          (bind "SUPER + left" (dsp ''focus({ direction = "left" })''))
          (bind "SUPER + right" (dsp ''focus({ direction = "right" })''))
          (bind "SUPER + up" (dsp ''focus({ direction = "up" })''))
          (bind "SUPER + down" (dsp ''focus({ direction = "down" })''))

          # Misc
          (bind "SUPER + V" (dsp ''window.float({ action = "toggle" })''))
          (bind "SUPER + F11" (dsp "window.fullscreen()"))

          # Move/Resize windows with mainMod + LMB/RMB and dragging
          (mouseBind "SUPER + mouse:272" (dsp "window.drag()"))
          (mouseBind "SUPER + mouse:273" (dsp "window.resize()"))
          (mouseBind "SUPER + Z" (dsp "window.drag()"))
        ]
        ++ workspaceBinds;
    };
  };
}
