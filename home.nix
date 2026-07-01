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
      ls = "eza";
			ll = "eza -l --header --git";
			la = "eza -la --header --git";
			tree = "eza -tree --git";
			va = "cd ~/.wine/drive_c/VASP";
      n = "nvim";
      update = "~/nixos/scripts/update.sh";
		};
		initExtra = ''
			export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
		'';
	};

	programs.alacritty = {
		enable = true;
		settings = {
			font.size = 13.0;
      window.decorations = "none";
			#window.opacity = 0.8;

			keyboard.bindings = [
				{ key = "Plus";			mods = "Control|Shift";	action = "IncreaseFontSize"; }
				{ key = "Semicolon";	mods = "Control";		action = "DecreaseFontSize"; }
				{ key = "Key0";			mods = "Control";		action = "ResetFontSize"; }
			];	
		};
	};

	programs.ghostty = {
		enable = true;
    settings = {
      keybind = [
        "ctrl+shift+;=increase_font_size:1"
      ];
      window-decoration = "none";
    };
  };

	programs.fd.enable = true;
	programs.fzf = {
		enable = true;
		defaultCommand = "fd --type f";
		fileWidgetCommand = "fd --type f";
		changeDirWidgetCommand = "fd --type d";
	};

  #programs.waybar.enable = true;
  programs.swayimg.enable = true;
  services.swayidle.enable = true;

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      font = "Noto Sans 12";
    };
  };

  gtk = {
    enable = true;
    gtk3.extraCss = ''
      .window-frame,
      decoration {
        border-radius: 0;
      }
      '';
    gtk4.extraCss = ''
      window,
      window.background,
      decoration {
        border-radius: 0;
      }
      '';

    #theme = {
      #name = "Colloid-Dark";
      #package = pkgs.colloid-gtk-theme;
    #};
    #cursorTheme = {
      #package = pkgs.colloid-cursors;
      #name = "Colloid";
    #};
    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid-Dark";
    };
  };

	home.packages = with pkgs; [
		fastfetch
		btop
    eza
    wget
    nvd
    xev
		pipewire.jack
		ripgrep
    zig
		wineWow64Packages.staging
		lxappearance
    adwaita-icon-theme
    colloid-icon-theme
    pavucontrol
    wlsunset
    swaybg
    hyprpicker
		reaper
    xwayland-satellite # for reaper in niri
		mousepad
    gedit
		vlc
		libnotify
    neovim
		rofi
    nautilus
    fuzzel
    pixman
    wayland
    libxkbcommon
    cairo
    libpng
		sioyek
    drawy
    anki
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
