{ config, pkgs, ... }:

{
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
      window-decoration = "none";
    };
  };

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
      n = "nvim";
		};
		initExtra = ''
			export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
		'';
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
    wget
    nvd
		wineWow64Packages.staging
		lxappearance
    pavucontrol
    wlsunset
		orchis-theme
		xinit
		mousepad
		picom
		feh
    xev
		reaper
    xwayland-satellite # needed for reaper in niri
		vlc
		xev
		libnotify
    neovim
		rofi
    pcmanfm
		dunst
    fuzzel
		sioyek
    drawy
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
