{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;

  boot.kernelModules = [
    "i2c-dev"
  ];
  #boot.kernelParams = [
    #"quiet"
    #"loglevel=3"
  #];

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "15s";
  }; 

	#services.sunshine = {
		#enable = true;
		#autoStart = true;
		#capSysAdmin = true;
		#openFirewall = true;
	#};

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;			# needed for realtime audio with pipewire
  services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  jack.enable = true;
	  pulse.enable = true;

	  wireplumber.extraConfig = {
		  "10-default-volume" = {
			  "wireplumber.settings"."device.routes.default-sink-volume" = 0.99;
		  };
	  };
	  extraConfig.pipewire."92-low-latency" = {
		  "context.properties" = {
			  "default.clock.rate" = 44100;
			  "default.clock.allowed-rates" = [ 44100 48000 88200 96000 176400 192000 ];
			  "default.clock.quantum" = 512;
			  "default.clock.min-quantum" = 512;
			  "default.clock.max-quantum" = 512;
		  };
	  };
  };

  networking.hostName = "amp"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  hardware.bluetooth.enable = true;
	hardware.graphics.enable = true;
  hardware.i2c.enable = true;

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = { 
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

    addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
    };
  };

  #environment.sessionVariables = {
    #GTK_IM_MODULE = "";
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."oliver" = {
    isNormalUser = true;
    description = "Oliver Grimm";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

	fonts.packages = with pkgs; [
		jetbrains-mono
		inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
	];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.udisks2.enable = true;


  services.displayManager.autoLogin = {
    enable = true;
    user = "oliver";
  };

  #services.desktopManager.plasma6.enable = true;
  #services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.enable = true;
  #programs.hyprland = {
    #enable = true;
    #withUWSM = true;
    #xwayland.enable = true;
  #};
  services.xserver.enable = true;
  programs.xwayland.enable = true;
  programs.niri = {
    enable = true;
  };

  services.displayManager.sddm.wayland.enable = true;
  #programs.river = {
    #enable = true;
    #xwayland.enable = true;
  #};

  #services.xserver = {
    #enable = true;
      ## for 4k:
      ##xrandr --output HDMI-A-0 --mode 3840x2160 --rate 120
    #displayManager.sessionCommands = ''
      #xrandr --output HDMI-A-0 --mode 1024x768 --rate 60
    #'';
    ## for 4k:
		##dpi = 168;
    ## also change rofi dpi in openbox.rc
		#dpi = 86;
		#deviceSection = '' Option "TearFree" "true" '';
		#videoDrivers = [ "amdgpu" ];
    #xkb.layout = "jp";
    #xkb.options = "ctrl:nocaps";
    #autoRepeatDelay = 250;
    #autoRepeatInterval = 30;
    #windowManager.openbox.enable = true;
  #};

  services.libinput = {
	  enable = true;
	  mouse = {
		  naturalScrolling = true;
		  accelSpeed = "-0.85";
	  };
	  touchpad = {
		  naturalScrolling = true;
	  };
  };

  programs.firefox.enable = true;
	programs.localsend.enable = true;
  programs.steam.enable = true;


  system.stateVersion = "26.05"; # Did you read the comment?
}
