{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan and my modules
    ./hardware-configuration.nix
    ./modules/index.nix
  ];

  # Define machine hostname (creative, don't you think?)
  networking.hostName = "nixos";

  # Set time zone
  time.timeZone = "America/Maceio";

  # Forgive me, Stallman sensei
  nixpkgs.config.allowUnfree = true;

  # System level packages
  environment.systemPackages = with pkgs; [
    xdg-utils
    acpi
    gnupg
    pinentry-all

    # Build and dev tools
    gcc # No need to explain
    binutils # Binary utilities
    cmake # CMake build system
    autoconf # Autoconf for configure scripts
    automake # Automake for makefile generation
    pkg-config # To manage library compile/link flags
    libtool # Generic library support
    gnumake # GNU Make

    # Making edit nix files more enjoyable
    nixd
    nixfmt-rfc-style
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Don't change it bro
  system.stateVersion = "24.05";

  # I use flakes btw
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
