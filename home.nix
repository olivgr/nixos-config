{ config, pkgs, ... }:

{
	home.username = "oliver";
	home.homeDirectory = "/home/oliver";
	home.stateVersion = "26.05";

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
	

	home.packages = with pkgs; [
		fastfetch
		btop
		alacritty
		wine64
		xinit
		brightnessctl
		redshift
		picom
		feh
		reaper
		xev
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
