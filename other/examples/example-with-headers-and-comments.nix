{ config, lib, pkgs, ... }:

{
  nyx-module = {
    system = {
      # Docker (System Module)
      #
      # Provides:
      #   - Docker runtime and CLI
      #   - Docker Compose
      #   - User access via `docker` group
      #   - Optional rootless mode and cgroup v2 support
      #
      # Options:
      #   - enable       → Enable Docker system module
      #   - username     → User to add to the docker group
      #   - enableOnBoot → Start Docker service on boot (default: true)
      #   - rootless     → Enable Docker rootless mode (disabled by default)
      #
      # Notes:
      #   - Rootless mode is disabled by default
      #   - Uses cgroup v2 for better resource management on modern kernels
      docker = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to the docker group.";
        username = "alice";
        
        # mkOption type=lib.types.bool
        # Whether to enable Docker service on boot.";
        enableOnBoot = true;
        
        # mkEnableOption (bool)
        rootless = true;
        
      };

      # OpenSSH (System Module)
      #
      # Provides:
      #   - OpenSSH server (sshd) service
      #
      # Options:
      #   - enable          → Enable OpenSSH system module
      #   - passwordAuth    → Allow password authentication (default: false)
      #   - permitRootLogin → Permit root login (default: "no")
      #
      # Notes:
      #   - By default, password authentication is disabled for better security
      #   - Root login is disabled unless explicitly enabled
      openssh = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.bool
        # Whether to allow password authentication.";
        passwordAuth = false;
        
        # mkOption type=lib.types.str
        # Whether to permit root login via SSH.";
        permitRootLogin = "no";
        
      };

      # Podman (System Module)
      #
      # Provides:
      #   - Podman runtime and CLI
      #   - Podman Compose
      #   - User access via `podman` group
      #
      # Options:
      #   - enable   → Enable Podman system module
      #   - username → User to add to the podman group
      #
      # Notes:
      #   - Adds podman + podman-compose to system packages
      #   - Enables D-Bus socket activation for Podman
      #
      podman = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to the podman group.";
        username = "alice";
        
      };

      # VM (System Module)
      #
      # Provides:
      #   - QEMU/KVM virtualization via libvirt
      #   - virt-manager GUI
      #   - User access via libvirtd and kvm groups
      #   - Spice, dnsmasq, and bridge-utils for networking and display
      #
      # Options:
      #   - enable   → Enable VM system module
      #   - username → User to add to virtualization groups (required)
      #
      # Notes:
      #   - QEMU runs as root by default (can be adjusted)
      #   - virt-manager GUI is enabled automatically
      #   - Only generic "kvm" kernel module is forced (host picks intel/amd)
      #
      vm = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to virtualization groups.";
        username = "alice";
        
      };

      # Zsh (System Module)
      #
      # Provides:
      #   - Zsh shell
      #   - oh-my-zsh integration
      #   - Theme + plugins support
      #
      # Options:
      #   - enable   → Enable Zsh system module
      #   - ohMyZsh  → Enable oh-my-zsh integration
      #   - theme    → oh-my-zsh theme (default: "xiong-chiamiov-plus")
      #   - plugins  → List of oh-my-zsh plugins (default: [ "git" ])
      #
      zsh = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        ohMyZsh = true;
        
        # mkOption type=lib.types.str
        # oh-my-zsh theme to use.";
        theme = "xiong-chiamiov-plus";
        
        # mkOption type=lib.types.listOf lib.types.str
        # List of oh-my-zsh plugins to enable.";
        plugins = [ "git" ];
        
      };

      # Steam (System Module)
      #
      # Provides:
      #   - Steam client
      #   - Optional firewall openings for:
      #       * Remote Play
      #       * Source Dedicated Server
      #       * Local Network Game Transfers
      #   - ProtonUp tool for managing Proton versions
      #
      # Options:
      #   - enable                   → Enable Steam system module
      #   - openFirewall.remotePlay  → Open firewall for Remote Play
      #   - openFirewall.dedicatedServer → Open firewall for Source Dedicated Server
      #   - openFirewall.localNetworkGameTransfers → Open firewall for LAN transfers
      #
      steam = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        remotePlay = true;
        
        # mkEnableOption (bool)
        dedicatedServer = true;
        
        # mkEnableOption (bool)
        localNetworkGameTransfers = true;
        
      };

      # Flatpak (System Module)
      #
      # Provides:
      #   - Flatpak package manager
      #   - Flatpak service integration
      #   - XDG portals for sandboxed apps
      #
      # Options:
      #   - enable → Enable Flatpak system module
      #
      flatpak = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Wireshark (System Module)
      #
      # Provides:
      #   - Wireshark installation
      #   - Proper dumpcap permissions
      #   - Adds user to `wireshark` group
      #
      # Options:
      #   - enable   → Enable Wireshark system module
      #   - username → User to add to the wireshark group (required)
      #
      wireshark = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.str
        # User to add to the wireshark group.";
        username = "alice";
        
      };

      # C Compiler (System Module)
      #
      # Provides:
      #   - GCC (C/C++)
      #   - Clang (alternative C/C++)
      #   - Mono (C#)
      #
      # Options:
      #   - enable → Enable C compiler toolchain
      #
      c-compiler = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Go (System Module)
      #
      # Provides:
      #   - Go programming language toolchain
      #
      # Options:
      #   - enable → Enable Go system module
      #
      go = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Lua (System Module)
      #
      # Provides:
      #   - Lua (standard interpreter)
      #   - LuaJIT (Just-In-Time compiler)
      #
      # Options:
      #   - enable → Enable Lua system module
      #
      lua = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Python (System Module)
      #
      # Provides:
      #   - Python 3 interpreter
      #   - Pip (package manager)
      #
      # Options:
      #   - enable → Enable Python system module
      #
      python = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Rust (System Module)
      #
      # Provides:
      #   - Rust compiler (rustc)
      #   - Cargo (Rust package manager & build system)
      #
      # Options:
      #   - enable → Enable Rust system module
      #
      rust = {
        # mkEnableOption (bool)
        enable = true;
        
      };

    };

    home = {
      # Brave Browser (Home Module)
      #
      # Provides:
      #   - Brave browser package
      #   - Optional standard and custom extension sets
      #
      # Options:
      #   - enable             → Enable Brave browser
      #   - extensions.enable  → Enable Brave extensions
      #   - extensions.standard→ Enable default extension set of extensions
      #   - extensions.extra   → Extra extension IDs to install
      #
      # Notes:
      #   - Default extensions include uBlock Origin, Proton Pass, Proton VPN
      #   - Extra extensions must be specified by Chrome Web Store ID
      #
      brave = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        standard = true;
        
        # mkOption type=lib.types.listOf lib.types.str
        # List of additional Brave extension IDs to install.";
        extra = [];
        
      };

      # Signal Desktop (Home Module)
      #
      # Provides:
      #   - Signal Desktop secure messaging client
      #
      # Options:
      #   - enable  → Enable Signal Desktop
      #   - package → Override package (default: pkgs.signal-desktop)
      #
      signal-desktop = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Package to install for signal-desktop.";
        package = pkgs.signal-desktop;
        
      };

      # Vesktop (Home Module)
      #
      # Provides:
      #   - Vesktop package (Discord client, Electron wrapper)
      #
      # Options:
      #   - enable  → Enable Vesktop client
      #   - package → Override package (default: pkgs.vesktop)
      #
      vesktop = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Package to install for vesktop.";
        package = pkgs.vesktop;
        
      };

      # RustDesk (Home Module)
      #
      # Provides:
      #   - RustDesk remote desktop software (TeamViewer/AnyDesk alternative)
      #
      # Options:
      #   - enable  → Enable RustDesk
      #   - package → Override package (default: pkgs.rustdesk)
      #
      # Notes:
      #   - Estimated build time: ~? Long....
      #
      rustdesk = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # ''
        package = pkgs.rustdesk;
        
      };

      # VSCodium (Home Module)
      #
      # Provides:
      #   - VSCodium editor (open-source build of VS Code)
      #   - Optional extension sets
      #
      # Options:
      #   - enable             → Enable VSCodium
      #   - extensions.enable  → Enable extensions
      #   - extensions.standard→ Enable standard extensions
      #   - extensions.extra   → Extra extensions to install
      #
      # Notes:
      #   - Some Microsoft extensions may be broken (e.g., ms-python.python)
      #
      vscodium = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        standard = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # List of extra VSCodium extensions to install.";
        extra = [];
        
      };

      # Classic Game Collection (Home Module)
      #
      # Provides:
      #   - Small set of lightweight, classic desktop games
      #
      # Included:
      #   - KPat (Patience / Solitaire)
      #   - KSudoku
      #   - Space Cadet Pinball
      #   - Palapeli (jigsaw puzzles)
      #   - KMines (Minesweeper clone)
      #   - KBlocks (Tetris clone)
      #   - KMahjongg (Mahjong solitaire)
      #
      # Options:
      #   - enable → Enable the Classic Game Collection
      #
      classic-game-collection = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # PrismLauncher (Home Module)
      #
      # Provides:
      #   - PrismLauncher (Minecraft launcher)
      #   - Optional inclusion of ffmpeg (some mods require it)
      #   - Configurable list of JDKs (for modpacks that need specific versions)
      #
      # Options:
      #   - enable       → Enable PrismLauncher
      #   - includeFfmpeg→ Include ffmpeg for mods
      #   - jdks         → List of Java runtimes for PrismLauncher
      #
      # Notes:
      #   - Installed via home.packages
      #   - JDKs are added to PATH so PrismLauncher can discover them
      #
      prismlauncher = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkEnableOption (bool)
        includeFfmpeg = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # List of Java runtimes to make available for PrismLauncher.";
        jdks = [ pkgs.jdk17 ];
        
      };

      # CAVA (Home Module)
      #
      # Provides:
      #   - CAVA audio visualizer
      #   - Declarative configuration via Nix
      #   - Support for structured settings or raw config override
      #
      # Options:
      #   - enable     → Enable CAVA (home module)
      #   - settings   → Declarative structured configuration (default: ALSA, 60 FPS, basic colors)
      #   - configText → Raw configuration text (overrides settings if set)
      #
      # Notes:
      #   - Writes config to ~/.config/cava/config
      #   - If configText is set, settings are ignored
      #
      # Example:
      #   nyx-module.home.cava = {
      #     enable = true;
      #     settings.general.framerate = 120;
      #     settings.input.method = "pulse";
      #   };
      cava = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.attrs
        settings =       default = {;
        
        # mkOption type=lib.types.nullOr lib.types.lines
        # ''
        configText = null;
        
      };

      # Spotify (music streaming client)
      #
      # Provides:
      #   - Spotify package (default)
      #   - Optional override to install a different package
      #
      # Notes:
      #   - Installs into home.packages
      #
      spotify = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # ''
        package = pkgs.spotify;
        
      };

      # Camera GUI module
      #
      # Provides:
      #   - Camera GUI package (default: snapshot)
      #   - libcamera (always installed, required backend)
      #
      # Notes:
      #   - You can override the GUI package with another (e.g., cheese, kamoso)
      #
      camera = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Camera GUI package to install.";
        package = pkgs.snapshot;
        
      };

      # Image Viewer
      #
      # Provides:
      #   - Installs a chosen image viewer application
      #
      # Notes:
      #   - Defaults to Gwenview
      #
      image-viewer = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Image viewer package to install (e.g. gwenview, feh, imv).";
        package = pkgs.gwenview;
        
      };

      # Krita (Digital Painting Software)
      #
      # Provides:
      #   - Krita package (open-source digital painting and illustration software)
      #
      # Notes:
      #   - Installed via home.packages
      #
      krita = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Kdenlive (video editor)
      #
      # Provides:
      #   - Kdenlive video editor
      #   - Installed via home.packages
      #
      # Notes:
      #   - Package location depends on nixpkgs version:
      #       * pkgs.kdePackages.kdenlive  (preferred, modern KDE split)
      #       * pkgs.libsForQt5.kdenlive   (older releases, fallback)
      #
      kdenlive = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Video Player(s)
      #
      # Provides:
      #   - Installs one or more chosen video/media players
      #
      # Notes:
      #   - Defaults to [ vlc ]
      #
      video-player = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # List of video/media players to install (e.g. vlc, mpv, celluloid).";
        packages = [ pkgs.vlc ];
        
      };

      # Zoom (video conferencing client)
      #
      # Provides:
      #   - Zoom package (default: pkgs.zoom-us)
      #
      # Options:
      #   - `package`: override the package (e.g. pkgs.zoom)
      #
      # Notes:
      #   - Installed via home.packages
      #
      zoom = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Zoom package to install (e.g., pkgs.zoom-us).";
        package = pkgs.zoom-us;
        
      };

      # Obsidian (note-taking / PKM app)
      #
      # Provides:
      #   - Obsidian package via home.packages
      #
      # Notes:
      #   - Consider adding theming support later
      #     (e.g., https://github.com/jackiejude/obsidian-temple-os)
      #
      obsidian = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # LibreOffice (office suite)
      #
      # Provides:
      #   - LibreOffice package via home.packages
      #
      # Notes:
      #   - Simple module, just adds LibreOffice to the user environment
      #
      libreoffice = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # PDF Viewer / Scanner
      #
      # Provides:
      #   - Install a chosen PDF or scanning GUI application
      #
      # Notes:
      #   - Defaults to Okular
      #
      pdf-reader = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # PDF or scanning GUI package to install (e.g. Okular, Evince, Xournal++).";
        package = pkgs.kdeApplications.okular;
        
      };

      # Printer GUI (scanning/printing tools)
      #
      # Provides:
      #   - Configurable GUI package for printing/scanning via home.packages
      #
      # Notes:
      #   - Default is `simple-scan` (GNOME Document Scanner)
      #   - Can be overridden with another package such as `system-config-printer`
      #
      printer-scan = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Printer/scanner GUI package to install.";
        package = pkgs.simple-scan;
        
      };

      # Thunderbird (email client)
      #
      # Provides:
      #   - Thunderbird package via home.packages
      #
      # Notes:
      #   - Simple module, just adds Thunderbird to the user environment
      #
      thunderbird = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # ProtonVPN (Home Module)
      #
      # Provides:
      #   - ProtonVPN GUI client
      #
      # Options:
      #   - enable → Enable ProtonVPN client
      #
      # Notes:
      #   - GUI only by default (CLI version available as pkgs.protonvpn-cli)
          
      protonvpn = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # CLI Tools (Home Module)
      #
      # Provides:
      #   - A curated set of command-line utilities in user’s environment
      #   - Examples: fastfetch, hyfetch, bat, fzf, tree, lsd, tmux
      #
      # Options:
      #   - enable → Enable CLI tools collection
      #   - extra  → List of extra packages to install
      tools = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.listOf lib.types.package
        # Extra CLI tools to install in addition to the defaults.";
        extra = [];
        
      };

      # Zsh (Home Module)
      #
      # Provides:
      #   - Zsh shell in the user profile
      #   - Zsh completion, autosuggestions, and syntax highlighting
      #
      # Options:
      #   - enable → Enable Zsh in the user profile
      zsh = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Private Webapps
      #
      # Provides:
      #   - Browser-based desktop entries for personal/private webapps
      #   - Currently supported:
      #       • WhatsApp
      #
      # Options:
      #   - browser   → Selects which browser package to use (default: chromium)
      #   - whatsapp  → Enable WhatsApp webapp launcher
      #
      # Notes:
      #   - Uses --app mode to create minimal browser windows
      #   - Additional services can be added following the same pattern
      private-webapps = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Browser package to use for private webapps.";
        browser = pkgs.chromium;
        
      };

      # Work Webapps
      #
      # Provides:
      #   - Browser-based desktop entries for work-related webapps
      #   - Currently supported:
      #       • Slack
      #       • Microsoft Teams
      #       • Outlook Web
      #       • Microsoft Entra
      #
      # Options:
      #   - browser  → Selects which browser package to use (default: chromium)
      #   - slack    → Enable Slack webapp launcher
      #   - teams    → Enable Teams webapp launcher
      #   - outlook  → Enable Outlook webapp launcher
      #   - entra    → Enable Entra webapp launcher
      #
      # Notes:
      #   - Uses --app mode for minimal windows (like PWAs)
      #   - Outlook entry uses a custom profile directory for isolation
      work-webapps = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.package
        # Browser package to use for private webapps.";
        browser = pkgs.chromium;
        
      };

    };

    hardware = {
      bluetooth = {
        # mkEnableOption (bool)
        enable = true;
        
      };

      # Custom Kernel Module for Microsoft Surface Pro (Kaby Lake / i5-7300U)
      #
      # Requires:
      #   - inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
      #
      # Notes:
      #   - Estimated kernel build time: ~4h30m
      #
      custom-kernel-surfacepro-kbl = {
        # mkEnableOption (bool)
        enable = true;
        
        # mkOption type=lib.types.enum [ "stable" "longtime" ]
        # Choose which kernel version nixos-hardware will build for Surface Pro.";
        kernelVersion = "stable";
        
      };

    };

  };
}
