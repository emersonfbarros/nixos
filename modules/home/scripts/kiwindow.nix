{
  flake.modules.homeManager.kiwindow =
    { pkgs, ... }:
    let
      kiwindow = pkgs.writeShellScriptBin "kiwindow" ''
        # Check if an argument was provided
        if [ $# -eq 0 ]; then
          exit 1
        fi

        # Save the windows array into a variable
        windows_data=$(${pkgs.kitty}/bin/kitty @ ls -t recent:0 | ${pkgs.jq}/bin/jq '.[0].tabs[0].windows')

        # Get the windows array length
        windows_length=$(echo "$windows_data" | ${pkgs.jq}/bin/jq 'length')

        # Check if the provided index is valid
        if [ "$1" -ge 0 ] && [ "$1" -lt "$windows_length" ]; then
          window_id=$(echo "$windows_data" | jq ".[$1].id")
          ${pkgs.kitty}/bin/kitten @ focus-window -m id:"$window_id"
        else
          exit 1
        fi
      '';
    in
    {
      home.packages = [ kiwindow ];
    };
}
