{ config, pkgs, ... }:

{
	imports = [
		./user/sh.nix
		./user/git.nix
	];

	home.username = "oliver";
	home.homeDirectory = "/home/oliver";
	home.stateVersion = "26.05";

	home.file.".config/openbox/rc.xml".source = ./.config/openbox/rc.xml;
	home.file.".config/openbox/autostart".source = ./.config/openbox/autostart;
	programs.ghostty = {
		enable = true;
		settings = {
      keybind = [
        "ctrl+shift+;=increase_font_size:1"
      ];
			#font-family = "JetBrains Mono";
			#background-opacity = 0.7;
      window-decoration = "none";
      window-width = 68;
      window-height = 22;
		};
	};

  programs.rofi = {
    enable = true;
    theme = "purple";
    font = "sans-serif";
    package = pkgs.rofi;
    modes = [
      "drun"
      "run"
      "window"
      "windowcd"
      "ssh"
    ];
    location = "center";
    terminal = "/etc/profiles/per-user/oliver/bin/ghostty";
    extraConfig = {
      show-icons = true;
    };
  };

	programs.alacritty = {
		enable = true;
		settings = {
			font = {
				normal = {
					family = "Jetbrains Mono";
				};
				size = 12.0;
			};
			window.opacity = 0.9;
			window.decorations = "None";

			keyboard.bindings = [
				{ key = "Plus";			mods = "Control|Shift";	action = "IncreaseFontSize"; }
				{ key = "Semicolon";	mods = "Control";		action = "DecreaseFontSize"; }
				{ key = "Key0";			mods = "Control";		action = "ResetFontSize"; }
				{ key = "F11";			action = "ToggleFullscreen";
				}
			];	
		};
	};


	programs.fd.enable = true;
	programs.fzf = {
		enable = true;
		defaultCommand = "fd --type f";
		fileWidgetCommand = "fd --type f";
		changeDirWidgetCommand = "fd --type d";
	};


	home.packages = with pkgs; [
		fastfetch
		btop
		eza
		tree
    wget
    nvd
		wineWow64Packages.staging
    polybar
    pavucontrol
    ddcutil
		#hyprlauncher
		#hyprpaper
    #hyprpicker
    #hyprlock
    #hyprpwcenter
    #hyprshutdown
    #grim
    #slurp
    #swappy
    #wlsunset
		lxappearance
    skippy-xd
    xmlstarlet
		drawy
		xinit
		mousepad
		brightnessctl
		picom
		feh
		reaper
		vlc
    sioyek
		xev
		libnotify
		dunst
    redshift
		pipewire.jack
		ripgrep
		neovim
		(pkgs.writeShellApplication
		{
			name = "ns";
			runtimeInputs = with pkgs; [
				fzf
				nix-search-tv
			];
			text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
		})
	];


	services.dunst = {		
		enable = true;
		settings = {
			global = {
				font = "monospace 13";
				width = 350; # max width in pixels
        transparency = 20;
        #origin = "top-center";
        #offset = "0x0";
			};
		};
	};
}
