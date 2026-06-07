{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = false;
  boot.loader.timeout = 0;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
  ];

  services.pulseaudio.enable = false;
# pipewire
  security.rtkit.enable = true;
  services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  jack.enable = true;
	  pulse.enable = true;

	  extraConfig.pipewire."92-low-latency" = {
		  context.properties = {
			  default.clock.rate = 44100;
			  default.clock.allowed-rates = [ 44100 ];
			  default.clock.quantum = 64;
			  default.clock.min-quantum = 64;
			  default.clock.max-quantum = 512;
		  };
	  };
	  extraConfig.pipewire."93-uln8" = {
		  monitor.alsa.rules = [
		  {
			matches = [
				{ "node.name" = "~alsa.*ULN8.*"; }
			];
			actions.update-props = {
				"audio.rate" = 44100;
				"audio.allowed-rates" = "44100";
				"api.alsa.period-size" = 64;
				"api.alsa.headroom" = 0;
			};
		  }
		  ];
	  };
		  
  };

  networking.hostName = "mynixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."oliver" = {
    isNormalUser = true;
    description = "Oliver Grimm";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
	tree
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    nvd
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "oliver";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "jp";
    xkb.options = "ctrl:nocaps";
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
    windowManager.openbox.enable = true;
  };

  programs.firefox.enable = true;
  programs.thunar.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}
