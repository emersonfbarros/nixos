{ pkgs, ... }:

{
  # Add base development tools to your environment
  home.packages = with pkgs; [
    gcc # Compiler toolchain (GCC)
    binutils # Binary utilities
    cmake # CMake build system
    autoconf # Autoconf for configure scripts
    automake # Automake for makefile generation
    pkg-config # To manage library compile/link flags
    libtool # Generic library support
    gnumake # GNU Make
  ];
}
