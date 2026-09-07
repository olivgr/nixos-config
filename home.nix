{ config, pkgs, ... }:

{
    home.username = "oliver";
    home.homeDirectory = "/home/oliver";
    home.stateVersion = "26.05";
    home.file.".config/openbox/rc.xml".source = ./.config/openbox/rc.xml;
    home.file.".config/openbox/autostart".source = ./.config/openbox/autostart;

    dconf.enable = true;

    programs.neovide.enable = true;

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
    xdg.portal = {
        enable = true;

        extraPortals = with pkgs; [
            #xdg-desktop-portal-hyprland
            xdg-desktop-portal-gtk
        ];

        config.common.default = "gtk";
        #config.hyprland = {
            #default = "hyprland;gtk";
        #};
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
            upgrade = "~/nixos/scripts/upgrade.sh";
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
    #wayland.windowManager.hyprland.systemd = {
        #enable = true;
        #variables = [ "--all" ];
    #};
    #wayland.windowManager.sway = {
    #    enable = true;
    #    systemd.enable = true;
    #    config = {
    #        bars = [];
    #    };

    #    extraConfig = ''
    #        input "type:keyboard" {
    #            xkb_layout jp
    #            xkb_options ctrl:nocaps
    #            repeat_delay 270
    #            repeat_rate 50
    #        } 
    #        input "type:pointer" {
    #            natural_scroll enabled
    #         }

    #        default_border normal 2

    #        set $mod Mod4
    #        floating_modifier $mod normal
    #        bindsym $mod+1 workspace number 1
    #        bindsym $mod+2 workspace number 2
    #        bindsym $mod+3 workspace number 3
    #        bindsym $mod+4 workspace number 4
    #        bindsym $mod+5 workspace number 5

    #        # Move windows to workspace
    #        bindsym $mod+Shift+1 move container to workspace number 1
    #        bindsym $mod+Shift+2 move container to workspace number 2
    #        bindsym $mod+Shift+3 move container to workspace number 3
    #        bindsym $mod+Shift+4 move container to workspace number 4
    #        bindsym $mod+Shift+5 move container to workspace number 5

    #        # Focus windows
    #        bindsym $mod+h focus left
    #        bindsym $mod+j focus down
    #        bindsym $mod+k focus up
    #        bindsym $mod+l focus right

    #        bindsym $mod+w kill
    #        bindsym $mod+f fullscreen toggle
    #        bindsym $mod+v floating toggle

    #        bindsym $mod+Shift+c reload
    #        bindsym $mod+Space exec ~/nixos/scripts/powermenu.sh
    #        bindsym $mod+Return exec ghostty
    #        bindsym $mod+e exec nautilus
    #        bindsym $mod+Shift+Return exec firefox
    #        bindsym $mod+y exec pw-jack reaper
    #        bindsym $mod+Shift+a exec anki
    #        bindsym $mod+n exec mousepad

    #        for_window [class="notepad.exe"] floating enable, focus
    #        for_window [class="vlc.exe"] floating enable, focus
    #        for_window [app_id="firefox"] border none
    #        for_window [app_id="org.xfce.mousepad"] floating enable, focus, border normal
    #        for_window [app_id="com.mitchellh.ghostty"] border pixel 0
    #        for_window [window_type="dialog"] floating enable

    #        exec quickshell -c ~/.config/quickshell/bar
    #        exec mako
    #        exec fcitx5 -d
    #        exec swaybg -i /home/oliver/Pictures/GR4/entrance.jpg -m fill
    #    '';
    #};

    #wayland.windowManager.sway = {
    #    enable = true;
    #    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    #    systemd.variables = ["--all"];
    #};

    programs.foot = {
        enable = true;
        settings = {
            main = {
                font = "monospace:size=12";
            };
        };
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
            #theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
            theme = "light:Catppuccin Latte, dark:Carbonfox";
            #theme = "Dark Pastel";
            font-size = 12;
            font-feature = [
                "-liga"
                "-calt"
                "-dlig"
            ];
            keybind = [
                "ctrl+shift+;=increase_font_size:1"
            ];
            window-decoration = "none";
            resize-overlay = "never";
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
    #programs.quickshell.enable = true;
    programs.eww.enable = true;
    #programs.swayimg.enable = true;
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


    #services.hypridle = {
        #enable = true;
        #settings = {
            #general = {
                #ignore_dbus_inhibit =false;
            #};
            #listener = [
                #{
                    #timeout = 300;
                    #on-timeout = ''hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' '';
                    #on-resume = ''hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' '';
                ##}
            #];
        #};
    #};

    # Notifications
    services.mako = {
        enable = true;
        settings = {
            default-timeout = 5000;
            font = "Noto Sans 12";
            margin = "44,4,0,0";
            markup = true;
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
        #sway
        swaybg      # wallpaper
        hyprpicker  # color-picker
        hyprpaper
#        brightnessctl
        reaper
#        xwayland-satellite # for reaper in niri
        mousepad    # notepad like
        xfce4-genmon-plugin
        gedit
        vlc
        darktable
        libnotify   # needed for notifications
        neovim
        neovim-remote
        nautilus    # file browser
#        thunar
        fuzzel      # file picker like rofi
        rofi
        wl-clipboard
        jq          # command line JSON processor
        sioyek
        drawy
        pinta
        anki
        abcde       # cd ripper
#        fractal     # matrix client
        goldendict-ng
        yt-dlp
        ffmpeg
        dua         # disk usage analyzer
        cliamp
        imv
        pulseaudio  # to get pactl
        pipewire-control-center
        woeusb-ng
#        opencode
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
