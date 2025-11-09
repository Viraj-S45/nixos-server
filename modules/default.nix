{ config, pkgs, lib, ... }:
let
in
{
  imports = [

    ./git.nix


  ];

  home.packages = with pkgs; [

  ];

}

