{ pkgs, ... }:
let
  yt = pkgs.writeShellScriptBin "yt" ''
    is_valid_youtube_url() {
      [[ "$1" =~ ^https://(www\.)?youtube\.com/watch\?v= ]] || [[ "$1" =~ ^https://youtu\.be/ ]]
    }

    main() {
      # Prompt user to input the YouTube URL
      link=$(echo "" | ${pkgs.tofi}/bin/tofi --require-match=false --prompt-text "Enter YouTube URL >  ")

      if [[ -z "$link" ]]; then
        notify-send "Error" "No URL entered."
        exit 1
      fi

      # Validate YouTube URL
      if ! is_valid_youtube_url "$link"; then
        notify-send "Error" "Invalid YouTube URL."
        exit 1
      fi

      # Prompt user to select video quality
      resolution=$(echo -e "360\n480\n720\n1080" | ${pkgs.tofi}/bin/tofi --prompt-text "Select Quality >  ")

      if [[ -z "$resolution" ]]; then
          notify-send "Error" "No resolution selected."
          exit 1
      fi

      # Execute mpv with the chosen options
      nohup ${pkgs.mpv}/bin/mpv --ytdl-format="bestvideo[height<=?$resolution]+bestaudio/best" "$link" >/dev/null 2>&1 &
      notify-send "YouTube" "Your video will start shortly."
    }

    main
  '';
in
{
  home.packages = [ yt ];
}
