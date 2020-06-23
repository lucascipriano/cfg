{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
      };
    };
  };

  networking = {
    useDHCP = false;
    hostName = "x571";
    extraHosts = "127.0.1.1 x571";
    networkmanager.enable = true;
      interfaces = {
        enp2s0f0.useDHCP = true;
        wlp3s0.useDHCP = true;
      };
  };
    programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    light.enable = true;
    nm-applet.enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };


   console = {
     font = "Lat2-Terminus16";
     keyMap = "br-abnt2";
   };

  time.timeZone = "America/Sao_Paulo";

   environment.systemPackages = with pkgs; 
   
    # base
    [ wget vim git python3 termite mkpasswd ]

      # Standard programs
    ++ [ flameshot vscodium ranger xclip]

      # Communication
      ++ [ tdesktop discord ]

      # Browsers
        ++ [ firefox google-chrome ]

        # Random
          ++ [ neofetch ];

  # Programas nofree
  nixpkgs.config.allowUnfree = true;

  #SSH
  services.openssh.enable = true;
  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "br";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.lucas = {
     isNormalUser = true;
     home = "/home/lucas";
     # hash generator [mkpasswd -m sha-512]
     hashedPassword = "$6$aM.2jBoCWEA$VoRKAB9mrSQvhEG1GZJzAXgQR2.gUPhbVlzm8GiCi9hkXB8xqUeku5ji/7WDEfaG6ek0gCooZPPH6GNbAWXZr1";
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };
   
  system.stateVersion = "20.03"; # Did you read the comment?

}
