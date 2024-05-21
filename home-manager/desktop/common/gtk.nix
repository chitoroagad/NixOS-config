{
    config,
    pkgs,
    lib,
    ...
}: 
    let 
        inherit (builtins)
            hashString toJson;
        rendersvg = pkgs.runCommand "rendersvg" {} ''
            mkdir -p $out/bin
            ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
        '';
        materialTheme = name: colours:
            pkgs.
    {
    
}
