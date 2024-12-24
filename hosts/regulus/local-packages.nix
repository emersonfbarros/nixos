{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ twingate ];
}
