{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
  ];

  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "15s";
  }; 

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
			  "default.clock.allowed-rates" = [ 44100 ];
			  "default.clock.quantum" = 512;
			  "default.clock.min-quantum" = 512;
			  "default.clock.max-quantum" = 512;
		  };
	  };
  };

  networking.hostName = "amp"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
	hardware.graphics.enable = true;

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

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
	];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.gvfs.enable = true;
  services.udisks2.enable = true;


  services.displayManager.autoLogin = {
    enable = true;
    user = "oliver";
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.enable = true;

  services.xserver = {
    enable = true;
		dpi = 86;
		deviceSection = '' Option "TearFree" "true" '';
		videoDrivers = [ "amdgpu" ];
    xkb.layout = "jp";
    xkb.options = "ctrl:nocaps";
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
    windowManager.openbox.enable = true;
  };
  services.libinput = {
	  enable = true;
	  mouse = {
		  naturalScrolling = true;
		  accelSpeed = "-0.7";
	  };
	  touchpad = {
		  naturalScrolling = true;
	  };
  };

  programs.firefox.enable = true;
  programs.thunar.enable = true;


  system.stateVersion = "26.05"; # Did you read the comment?
}
