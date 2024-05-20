{
    config,
    lib,
    pkgs,
    ...
}: {
    programs.wofi = {
        enable = true;
        settings = {
            image_size = 40;
            columns = 2;
            allow_images = true;
        };
    };
}
