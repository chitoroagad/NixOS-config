{...}: {
  services.wlsunset = {
    enable = true;

    # London
    latitude = 51.509865;
    longitude = -0.118092;
  };

  # services.hyprsunset = {
  #   enable = true;
  #   settings = {
  #     profile = [
  #       {
  #         time = "6:30";
  #         identity = true;
  #       }
  #     ];
  #   };
  # };
}
