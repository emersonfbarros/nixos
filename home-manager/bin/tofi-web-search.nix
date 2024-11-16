{ pkgs, ... }:
let
  webSearchScript = pkgs.writeShellScriptBin "tofi-web-search" ''
    declare -A URLS
    URLS=(
      ["google"]="https://www.google.com/search?q="
      ["bing"]="https://www.bing.com/search?q="
      ["duckduckgo"]="https://www.duckduckgo.com/?q="
      ["yandex"]="https://yandex.ru/yandsearch?text="
      ["github"]="https://github.com/search?q="
      ["goodreads"]="https://www.goodreads.com/search?q="
      ["stackoverflow"]="http://stackoverflow.com/search?q="
      ["symbolhound"]="http://symbolhound.com/?q="
      ["searchcode"]="https://searchcode.com/?q="
      ["openhub"]="https://www.openhub.net/p?ref=homepage&query="
      ["superuser"]="http://superuser.com/search?q="
      ["askubuntu"]="http://askubuntu.com/search?q="
      ["imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
      ["rottentomatoes"]="https://www.rottentomatoes.com/search/?search="
      ["youtube"]="https://www.youtube.com/results?search_query="
      ["vimawesome"]="http://vimawesome.com/?q="
      ["rarbg"]="https://proxyrarbg.org/torrents.php?search="
      ["nyaa"]="https://nyaa.si/?f=0&c=0_0&q="
      ["genius"]="https://genius.com/search?q="
    )

    # List for rofi
    gen_list() {
      for i in "''${!URLS[@]}"; do
        echo "$i"
      done
    }

    main() {
      # Pass the list to rofi
      platform=$( (gen_list) | ${pkgs.tofi}/bin/tofi --prompt-text "Search >")

      if [[ -n "$platform" ]]; then
        query=$(echo "" | ${pkgs.tofi}/bin/tofi --require-match=false --prompt-text "$platform >  ")

        if [[ -n "$query" ]]; then
          url=''${URLS[$platform]}$query
          xdg-open "$url"
        else
          exit
        fi

      else
        exit
      fi
    }

    main

    exit 0
  '';
in
{
  home.packages = [ webSearchScript ];
}
