{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  systemd.user.services.autolms = {
    description = "Autolms scraper";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/home/virajs/test/autolms/lms.sh";
      WorkingDirectory = "/home/virajs/test/autolms";
      StandardOutput = "journal";
      StandardError = "journal";
    };
  };

  systemd.user.timers.autolms = {
    description = "Run Autolms scraper twice daily";
    timerConfig = {
      OnCalendar = [ "*-*-* 09:00:00" "*-*-* 21:00:00" ];
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];  # optional, good practice
  };



  # Flakes enabled
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Host config
  networking.hostName = "virajs"; 

  # networking options.
  networking.networkmanager.enable = true;  

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Static IP Addr
  networking.useDHCP = false;

  # Faster Swappiness
  boot.kernel.sysctl."vm.swappiness" = 60;

  networking.interfaces.enp3s0.ipv4.addresses = [
    {
      address = "192.168.1.104";
      prefixLength = 24;
    }
  ];

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.virt-manager.package = pkgs.virt-manager;
  

  programs.zsh.enable = true;
  
  # user account.
  users.users.virajs= {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "kvm" ]; 
    packages = with pkgs; [
            
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim 
    neovim

    wget
    git

    nettools
    bash
    lazygit
    lazydocker
    ripgrep
    neofetch
    btop
    lsof
    openssl
    iproute2
    docker-compose
    gcc

    tree
    btop
    fastfetch
    oh-my-zsh
    fzf
    zoxide
    dmidecode
    pciutils
    lshw

    
    


  ];
  
  # 1TB_HDD Mount 
  fileSystems."/mnt/1TB_HDD" = {
    device = "/dev/disk/by-uuid/98dea232-fa5b-4957-8c53-934ae1ae850e";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  # List services that you want to enable:

  # Docker Enabled
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
   # --Password less sudo for user--

   security.sudo.extraRules = [{
     users = ["virajs"];
     commands = [{ command = "ALL";
       options = ["NOPASSWD"];
       }];
     }];

  networking.extraHosts = ''
  127.0.0.1 server.vaultwarden
  127.0.0.1 server.uptimekuma
  127.0.0.1 server.homepage
  127.0.0.1 server.portainer
  127.0.0.1 server.nexterm
  127.0.0.1 server.nextcloud
  127.0.0.1 server.beszel
  127.0.0.1 server.jupyterhub
  127.0.0.1 server.mediacms
  127.0.0.1 server.ntfy
  127.0.0.1 server.ariang
  
  
  
 
  

  
  
  

  ''; 
  
  # WOL
  networking.interfaces.enp3s0.wakeOnLan.enable = true;
  
   
 

  
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

