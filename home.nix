{ config, pkgs, imports, ... }:
{

  

  imports = [
  ./modules

  ];  

    

  home.username = "virajs";
  home.homeDirectory = "/home/virajs";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    wakeonlan
    python313                # Python 3.13
    virtualenv               # Python envs
    direnv    
    rclone
    gh
    git-hub
    nodejs_22

  ];

   

home.file = {
 };


  home.sessionVariables = {

  };

  programs.home-manager.enable = true;

}

