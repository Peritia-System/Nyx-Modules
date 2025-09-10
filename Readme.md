# Nyx-Modules

Welcome to **Nyx-Modules**!

This is my repo with all my modules, which makes it easier for me to import them into different configurations. Maybe it helps someone else too.

`Modules` contains all the modules:

```text
Modules
├── Hardware
├── Home
└── System
```

<details>
<summary>Full tree</summary>

```bash
Modules
├── Hardware
│   ├── Bluetooth
│   │   ├── bluetooth.nix
│   │   └── default.nix
│   ├── default.nix
│   └── Surface
│       ├── custom-kernel-surfacepro-kbl.nix
│       ├── default.nix
│       └── thermal-conf.xml
├── Home
│   ├── default.nix
│   ├── GUI-Apps
│   │   ├── Browsers
│   │   │   ├── brave.nix
│   │   │   └── default.nix
│   │   ├── Communication
│   │   │   ├── default.nix
│   │   │   ├── Messaging
│   │   │   │   ├── default.nix
│   │   │   │   ├── signal-desktop.nix
│   │   │   │   └── vesktop.nix
│   │   │   └── Remote-Support
│   │   │       ├── default.nix
│   │   │       └── rustdesk.nix
│   │   ├── default.nix
│   │   ├── Development
│   │   │   ├── default.nix
│   │   │   └── vscodium.nix
│   │   ├── Gaming
│   │   │   ├── classic-game-collection.nix
│   │   │   ├── default.nix
│   │   │   └── prismlauncher.nix
│   │   ├── Multimedia
│   │   │   ├── Audio
│   │   │   │   ├── cava.nix
│   │   │   │   ├── default.nix
│   │   │   │   └── spotify.nix
│   │   │   ├── Capture
│   │   │   │   ├── camera.nix
│   │   │   │   └── default.nix
│   │   │   ├── default.nix
│   │   │   ├── Graphics
│   │   │   │   ├── default.nix
│   │   │   │   ├── image-viewer.nix
│   │   │   │   └── krita.nix
│   │   │   └── Video
│   │   │       ├── default.nix
│   │   │       ├── kdenlive.nix
│   │   │       ├── video-player.nix
│   │   │       └── zoom.nix
│   │   ├── Office
│   │   │   ├── default.nix
│   │   │   ├── Knowledge
│   │   │   │   ├── default.nix
│   │   │   │   └── obsidian.nix
│   │   │   └── Productivity
│   │   │       ├── default.nix
│   │   │       ├── libreoffice.nix
│   │   │       ├── pdf-reader.nix
│   │   │       ├── printer-scan.nix
│   │   │       └── thunderbird.nix
│   │   └── VPN
│   │       ├── default.nix
│   │       └── protonvpn.nix
│   ├── Shell
│   │   ├── cli-tools
│   │   │   ├── default.nix
│   │   │   └── tools.nix
│   │   ├── default.nix
│   │   └── zsh
│   │       ├── default.nix
│   │       └── zsh.nix
│   └── Webapps
│       ├── default.nix
│       ├── private-webapps.nix
│       └── work-webapps.nix
└── System
    ├── Application
    │   ├── cli
    │   │   ├── default.nix
    │   │   ├── docker.nix
    │   │   ├── openssh.nix
    │   │   ├── podman.nix
    │   │   ├── vm.nix
    │   │   └── zsh.nix
    │   ├── default.nix
    │   ├── Gaming
    │   │   ├── default.nix
    │   │   └── Steam
    │   │       ├── default.nix
    │   │       └── steam.nix
    │   └── Special-Applications
    │       ├── default.nix
    │       ├── flatpak.nix
    │       └── wireshark.nix
    ├── default.nix
    └── Programming-Tools
        ├── c-compiler.nix
        ├── default.nix
        ├── go.nix
        ├── lua.nix
        ├── python.nix
        └── rust.nix
```

Yeah… it is a lot. That is why I recommend using this mainly as a reference for your own modules. Rather than to Import it into your Config.

</details>


I’m not claiming this will be super helpful for everyone — it’s mostly a guideline for writing modules that are easy to sync across devices.

---

## How to Use
_If you decide to adapt it in your config_

### Adding Nyx-Modules to your Flake

```nix
{
  description = "Your Flake";

  inputs = {
    # Other inputs...
    
    # Nyx-Modules
    nyx-modules.url = "github:Peritia-System/Nyx-Modules";
    nyx-modules.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { nyx-modules, ... }: {
    nixosConfigurations.HOSTNAME = nixpkgs.lib.nixosSystem {
      modules = [
        nyx-modules.nixosModules.default
        ./configuration.nix
      ];
    };
  };
}
```

### Importing in `configuration.nix`

```nix
imports = [
  # your other imports...

  # Nyx-Modules
  inputs.nyx-modules.nixosModules.default

  # Hardware-specific modules
  inputs.nyx-modules.nixosModules.hardware 
];
```

### Importing in `home.nix`

```nix
imports = [
  inputs.nyx-modules.homeManagerModules.default
  ./desktop.nix
];
```

## What Options are there? 

Alot.  
To get the full extend and use this repo fully you would best go through each file....   
But that is not really viable so check: `other/example` this is a shortend Version of what I use for one of my Systems.  

## Notes

- Again this repository is intended as a guideline and reference for building modular Nix configurations
- Feel free to adapt any modules to your own setup
- Modules are organized by purpose (Hardware, Home, System) to make them easy to reuse across multiple machines
- I also love it if you are interested and want to contribute too 
