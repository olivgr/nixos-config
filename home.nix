{ config, pkgs, ... }:

{
    home.username = "oliver";
    home.homeDirectory = "/home/oliver";
    home.stateVersion = "26.05";

    home.file.".config/openbox/rc.xml".source = ./.config/openbox/rc.xml;
    home.file.".config/openbox/autostart".source = ./.config/openbox/autostart;

    dconf.enable = true;

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
            kate = "WINEDEBUG=-all wine '/home/oliver/.wine/drive_c/Program Files/Kate/bin/kate.exe'";
            n = "nvim";
            update = "~/nixos/scripts/update.sh";
        };
        initExtra = ''
            export PS1='\[\e[38;5;76m\]\u@\h\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
            '';
        bashrcExtra = ''
            if [[ -n "$SSH_CONNECTION" ]]; then 
                export XDG_RUNTIME_DIR="/run/user/$(id -u)"
                    export WAYLAND_DISPLAY="wayland-1"
                    export DISPLAY=":0"
                    fi
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
            theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
            #theme = "Dark Pastel";
            font-size = 13;
            font-feature = [
                "-liga"
                "-calt"
                "-dlig"
            ];
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
        fileWidget.command = "fd --type f";
        changeDirWidget.command = "fd --type d";
    };

    programs.onlyoffice.enable = true;
    programs.quickshell.enable = true;
    programs.eww.enable = true;
    programs.swayimg.enable = true;
    programs.firefox = {
        enable = true;
        #nativeMessagingHosts = [
            #pkgs.keepassxc
        #];
    };
    programs.keepassxc = {
        enable = true;
        #settings = {
            #Browser.UpdateBinaryPath = false;
        #};
    };

    services.swayidle.enable = true;

    # Notifications
    services.mako = {
        enable = true;
        settings = {
            default-timeout = 5000;
            font = "Noto Sans 12";
            margin = "44,4,0,0";
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

        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 0;
        };

        gtk4.extraCss = ''
            window,
            window.background,
            decoration {
                border-radius: 0;
            }
        '';

        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 0;
        };

        iconTheme = {
            package = pkgs.colloid-icon-theme;
            name = "Colloid-Dark";
        };
    };

    home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 24;
    };

    home.packages = with pkgs; [
        fastfetch
        dconf
        glib
        gnome-themes-extra
        btop
        eza         # ls replacement
        wget
        nvd         # show package diffs
        xev
        pipewire.jack
        ripgrep
        glfw
        #clang
        zig
        wineWow64Packages.staging
        colloid-icon-theme
        colloid-gtk-theme
        apple-cursor
        pavucontrol
        wlsunset
        swaybg      # wallpaper
        hyprpicker  # color-picker
        reaper
        xwayland-satellite # for reaper in niri
        mousepad    # notepad like
        gedit
        vlc
        darktable
        libnotify   # needed for notifications
        neovim
        neovim-remote
        nautilus    # file browser
        thunar
        fuzzel      # file picker like rofi
        wl-clipboard
        jq          # command line JSON processor
        sioyek
        drawy
        anki
        lmstudio
        abcde       # cd ripper
        fractal     # matrix client
        goldendict-ng
        yt-dlp
        ffmpeg
        cliamp
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
