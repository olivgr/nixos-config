{ config, pkgs, ... }:

{
	home.username = "oliver";
	home.homeDirectory = "/home/oliver";
	home.stateVersion = "26.05";

	home.file.".config/openbox/rc.xml".source = ./.config/openbox/rc.xml;
	home.file.".config/openbox/autostart".source = ./.config/openbox/autostart;

	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "Oliver Grimm";
				email = "olivergrimm@fastmail.fm";
			};
			alias = {
				lg = "log --oneline --graph";
			};
		};
	};
	programs.bash = {
		enable = true;
		shellAliases = {
			ll = "ls -alF";
			va = "cd ~/.wine/drive_c/VASP";
		};
		initExtra = ''
			export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
		'';
	};

	programs.alacritty = {
		enable = true;
		settings = {
			font.size = 12.0;

			keyboard.bindings = [
				{ key = "Plus";			mods = "Control|Shift";	action = "IncreaseFontSize"; }
				{ key = "Semicolon";	mods = "Control";		action = "DecreaseFontSize"; }
				{ key = "Key0";			mods = "Control";		action = "ResetFontSize"; }
			];	
		};
	};

	home.packages = with pkgs; [
		fastfetch
		btop
		wine64
		xinit
		brightnessctl
		redshift
		picom
		feh
		reaper
		xev
		fzf
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
}
