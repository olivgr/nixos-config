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

	programs.alacritty = {
		enable = true;
		settings = {
			font.size = 11.0;
			window.opacity = 0.9;

			keyboard.bindings = [
				{ key = "Plus";			mods = "Control|Shift";	action = "IncreaseFontSize"; }
				{ key = "Semicolon";	mods = "Control";		action = "DecreaseFontSize"; }
				{ key = "Key0";			mods = "Control";		action = "ResetFontSize"; }
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
		wine64
		lxappearance
		drawy
		orchis-theme
		xinit
		mousepad
		brightnessctl
		redshift
		picom
		feh
		reaper
		vlc
		xev
		libnotify
		dunst
		pipewire.jack
		ripgrep
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
				font = "monospace 16";
				width = 400; # max width in pixels
			};
		};
	};
}
