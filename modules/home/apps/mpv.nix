{
  flake.modules.homeManager.mpv = {
    programs.mpv = {
      enable = true;

      config = {
        profile = "gpu-hq";
        vo = "gpu-next";
        gpu-api = "vulkan";
        hwdec = true;
        dither-depth = "auto";
        target-colorspace-hint = true;
        audio-exclusive = false;
        audio-channels = "auto-safe";
        sub-fix-timing = true;
        video-sync = "display-resample";
        interpolation = true;

        profile-cond = ''p["video-params/pixelformat"] == "yuv420p"'';
        deband = true;
        deband-iterations = 2;
        deband-threshold = 32;
        deband-range = 16;
        deband-grain = 0;
      };
    };
  };
}
