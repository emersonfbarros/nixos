{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc # No need to explain
    binutils # Binary utilities
    cmake # CMake build system
    autoconf # Autoconf for configure scripts
    automake # Automake for makefile generation
    pkg-config # To manage library compile/link flags
    libtool # Generic library support
    gnumake # GNU Make
  ];
}
