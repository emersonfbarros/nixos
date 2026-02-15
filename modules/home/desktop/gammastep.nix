{
  flake.modules.homeManager.gammastep = {
    services.gammastep = {
      enable = true;

      temperature = {
        day = 6500;
        night = 2500;
      };

      dawnTime = "5:20-5:40";
      duskTime = "17:46-18:06";

      settings = {
        general = {
          fade = 1;
          adjustment-method = "wayland";
          gamma = 0.8;
        };
      };
    };
  };
}
