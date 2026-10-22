 { config, pkgs, lib, ... }:

{

    home.username = "oliver";
    home.homeDirectory = "/home/oliver";
    home.stateVersion = "26.05";
    home.file.".config/openbox/rc.xml".source = ./.config/openbox/rc.xml;
    home.file.".config/openbox/autostart".source = ./.config/openbox/autostart;

    dconf.enable = true;

    programs.neovide.enable = true;

    programs.lazygit.enable = true;

    # for automatically activating nix-shell on directory enter
    programs.direnv= {
        enable = true;
        nix-direnv.enable = true;
    };
    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "Oliver Grimm";
                email = "olivergrimm@fastmail.fm";
            };
            init.defaultBranch = "main";
            alias = {
                lg = "log --oneline --graph";
            };
        };
    };
    xdg.portal = {
        enable = true;

        extraPortals = with pkgs; [
            xdg-desktop-portal-hyprland
            xdg-desktop-portal-gtk
        ];

        config.common.default = "gtk";
        config.hyprland = {
            default = "hyprland;gtk";
        };
    };

    programs.bash = {
        enable = true;
        shellAliases = {
            gs = "git status";
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
            #export PS1='\[\e[34m\]\h \[\e[38;5;76m\]\u@\h\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
            #---------------------------------------------------------------------------
            # Prompt
            #---------------------------------------------------------------------------
            RED="\033[0;31m"
            BROWN="\033[0;33m"
            GREY="\033[0;97m"
            GREEN="\033[0;32m"
            BLUE="\033[0;34m"
            PS_CLEAR="\033[0m"
            SCREEN_ESC="\033k\033\134"

            COLOR1="''${BLUE}"
            COLOR2="''${BLUE}"
            P="\$"

            prompt_simple() {
              unset PROMPT_COMMAND
              PS1="\W\$(parse_git_branch) → "
              PS2="> "
            }

            prompt_compact() {
              unset PROMPT_COMMAND
              PS1="''${COLOR1}''${P}''${PS_CLEAR} "
              PS2="> "
            }

            prompt_color() {
              PS1="\[\e[0;34m\]\h \[\e[0;32m\]\W\$(parse_git_branch) → \[\e[0;97m\]"
              PS2="\[\e[33;1m\]continue \[\e[0m\]\[\e[1m\]> "
            }

            parse_git_branch() {
              local branch
              local staged=""
              local unstaged=""

              branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return 1

              # Staged changes: index differs from HEAD
              if ! git diff --cached --quiet 2>/dev/null; then
                staged="+"
              fi

              # Unstaged changes: working tree differs from index
              if ! git diff --quiet 2>/dev/null; then
                unstaged="!"
              fi
                    
              printf ' %s%s%s' "$branch" "$staged" "$unstaged"
            }

            test -n "$PS1" &&
            prompt_color

            eval "$(direnv hook bash)"
        '';

        bashrcExtra = ''
            if [[ -n "$SSH_CONNECTION" ]]; then 
                export XDG_RUNTIME_DIR="/run/user/$(id -u)"
                    export WAYLAND_DISPLAY="wayland-1"
                    export DISPLAY=":0"
                    fi
                    '';

    };

    programs.foot = {
        enable = true;
        settings = {
            main = {
                font = "monospace:size=12";
                include = "~/.config/foot/themes/catppuccin-macchiato.ini";
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

    programs.ghostty.enable = true;

    programs.fd.enable = true;
    programs.fzf = {
        enable = true;
        #enableNushellIntegration = false;
        defaultCommand = "fd --type f";
        fileWidgetCommand = "fd --type f";
        changeDirWidgetCommand = "fd --type d";
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


#    services.swayidle = {
#        enable = true;
#        timeouts = [
#            {
#                timeout = 180;
#                command = "/run/current-system/sw/bin/mmsg dispatch sleep_monitor,HDMI-A-1";
#                resumeCommand = "/run/current-system/sw/bin/mmsg dispatch wakeup_monitor,HDMI-A-1";
#            }
#        ];
#    };
#
#    systemd.user.services.swayidle = {
#        Unit = {
#            After = lib.mkForce [ ];
#            PartOf = lib.mkForce [ ];
#        };
#        Install.WantedBy = lib.mkForce [ "default.target" ];
#    };

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
        size = 22;
    };

    home.packages = with pkgs; [
        neovim
        fastfetch                   # System information display
        dconf                       # GNOME settings database
        glib                        # Core GNOME libraries and utilities
        nerd-fonts.iosevka-term     # Iosevka Term Nerd Font
        nerd-fonts.iosevka          # Iosevka Nerd Font
        gnome-themes-extra          # Additional GTK themes
        btop                        # Interactive system resource monitor
        eza                         # Modern ls replacement
        #wget                        # Download files from URLs
        nvd                         # Show Nix package version diffs
        #xev                         # Inspect X11 keyboard and mouse events
        pipewire.jack               # JACK audio compatibility for PipeWire
        ripgrep                     # Fast recursive text search
        #geany                       # Lightweight graphical text editor
        #clang                      # C/C++ compiler toolchain
        #zig                         # Zig programming language and compiler
        #wev                         # Inspect Wayland keyboard events
        colloid-icon-theme          # Colloid desktop icon theme
        colloid-gtk-theme           # Colloid GTK theme
        apple-cursor                # macOS-style mouse cursor theme
        pavucontrol                 # GUI audio mixer and device selector
        wlsunset                    # Adjust screen color temperature by time
        grim                        # Take Wayland screenshots
        slurp                       # Select screen regions on Wayland
        satty                       # Annotate screenshots
        swaybg                      # Set desktop wallpaper
        swayidle
        #hyprpicker                  # Pick colors from the screen
        reaper                      # Digital audio workstation
        mousepad                    # Lightweight graphical text editor
        #xrdb                        # Manage X11 resource settings
        gedit                       # Graphical text editor
        vlc                         # Multimedia player
        libnotify                   # Desktop notification library and tools
        neovim-remote               # Control Neovim from other processes
        nautilus                    # GNOME file manager
        #thunar                      # File manager
        fuzzel                      # Wayland application launcher
        rofi                        # Application launcher and menu
        wl-clipboard                # Wayland clipboard utilities
        #jq                          # Command-line JSON processor
        sioyek                      # PDF reader for technical documents
        #drawy                       # Drawing and annotation tool
        #pinta                       # Simple raster image editor
        #anki                        # Flashcard-based learning application
        #openlogi                    # Logitech device configuration utility
        #abcde                       # Rip audio CDs to digital files
        #goldendict-ng               # Dictionary lookup application
        #yt-dlp                      # Download video and audio from websites
        #ffmpeg                      # Audio and video conversion tools
        #dua                         # Interactive disk usage analyzer
        #cliamp                      # Command-line audio player
        imv                         # Lightweight image viewer
        pulseaudio                  # Provides pactl audio control utility
        #pipewire-control-center     # GUI for PipeWire audio settings
        #woeusb-ng                   # Create Windows installation USB drives
        #mullvad-browser            # Privacy-focused web browser
        wayvnc                      # VNC server for wlroots Wayland compositors
        wineWow64Packages.staging
        wine64Packages.fonts         
        #wdisplays                   # Configuring displays for Wayland compositors
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
