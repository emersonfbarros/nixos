{ pkgs, homeStateVersion, ... }:
let
  webSearchScript = pkgs.writeShellScriptBin "tofi-web-search" ''
    declare -A URLS
    URLS=(
      ["Google"]="https://www.google.com/search?q="
      ["Bing"]="https://www.bing.com/search?q="
      ["Duckduckgo"]="https://www.duckduckgo.com/?q="
      ["Yandex"]="https://yandex.ru/yandsearch?text="
      ["Github"]="https://github.com/search?q="
      ["Goodreads"]="https://www.goodreads.com/search?q="
      ["Stackoverflow"]="http://stackoverflow.com/search?q="
      ["Symbolhound"]="http://symbolhound.com/?q="
      ["Searchcode"]="https://searchcode.com/?q="
      ["Openhub"]="https://www.openhub.net/p?ref=homepage&query="
      ["Superuser"]="http://superuser.com/search?q="
      ["Askubuntu"]="http://askubuntu.com/search?q="
      ["Imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
      ["Rottentomatoes"]="https://www.rottentomatoes.com/search/?search="
      ["Youtube"]="https://www.youtube.com/results?search_query="
      ["Vimawesome"]="http://vimawesome.com/?q="
      ["Rarbg"]="https://proxyrarbg.org/torrents.php?search="
      ["Nyaa"]="https://nyaa.si/?f=0&c=0_0&q="
      ["Genius"]="https://genius.com/search?q="
      "[MyNixOS]=https://mynixos.com/search?q="
      "[Nixpkgs]=https://search.nixos.org/packages?channel=${homeStateVersion}&from=0&size=50&sort=relevance&type=packages&query="
    )

    # List for rofi
    gen_list() {
      for i in "''${!URLS[@]}"; do
        echo "$i"
      done
    }

    main() {
      # Pass the list to rofi
      platform=$( (gen_list) | ${pkgs.tofi}/bin/tofi --prompt-text "Search >  ")

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
