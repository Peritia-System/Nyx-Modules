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
        enable = true;
        
        username = "alice";
        
        enableOnBoot = true;
        
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
        enable = true;
        
        passwordAuth = false;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
        ohMyZsh = true;
        
        theme = "xiong-chiamiov-plus";
        
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
        enable = true;
        
        remotePlay = true;
        
        dedicatedServer = true;
        
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
        enable = true;
        
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
        enable = true;
        
        enable = true;
        
        standard = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
        enable = true;
        
        standard = true;
        
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
        enable = true;
        
        includeFfmpeg = true;
        
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
        enable = true;
        
        settings =       default = {;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
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
        enable = true;
        
        browser = pkgs.chromium;
        
      };

    };

    hardware = {
      bluetooth = {
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
        enable = true;
        
        kernelVersion = "stable";
        
      };

    };

  };
}
