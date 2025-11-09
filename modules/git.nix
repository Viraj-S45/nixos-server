{ config, pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs; [

  ];

  programs.git = {
    enable = true;
    userName = "git-automator";
    userEmail = "linuxcoder9@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };




}

