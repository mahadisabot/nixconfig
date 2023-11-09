{ config, pkgs, inputs, ... }:

{
    # Remove unecessary preinstalled packages
    environment.defaultPackages = [ ];
    services.xserver.desktopManager.xterm.enable = false;
services.xserver.enable = true;
services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;
    programs.fish.enable = true;
  
  services.xserver.layout = "us";
  services.xserver.videoDrivers = [ "intel" ]; # or appropriate video driver
 



    # Laptop-specific packages (the other ones are installed in `packages.nix`)
    environment.systemPackages = with pkgs; [
git nano
waybar-hyprland
networkmanager
    networkmanagerapplet
    blueman
    python39
    rustup
    kitty
    fish
   
    
    swayidle
    swaylock-effects
    grim
    slurp
    mako
    wl-clipboard
    
    cliphist
    swww
  
    swappy
    wofi

    wofi-emoji
    material-design-icons
    iosevka
    xdg-user-dirs
    noto-fonts-emoji
    libsForQt5.polkit-kde-agent
    clipman
    imagemagick
    hyprpicker
    gpick
    acpi
    libsForQt5.qt5ct
    
  
 
   

    brightnessctl
    pamixer
    papirus-icon-theme
    

    xfce.thunar
    
    cava
    spicetify-cli
    ];

    # Install fonts
    fonts = {
        fonts = with pkgs; [
             iosevka
            jetbrains-mono
            noto-fonts-emoji

            openmoji-color
            
            (nerdfonts.override { fonts = [ "jetbrains-mono" ]; })
        ];

        fontconfig = {
            hinting.autohint = true;
            defaultFonts = {
              emoji = [ "noto-fonts-emoji" ];
            };
        };
    };

services.blueman.enable = true;
    # Wayland stuff: enable XDG integration, allow sway to use brillo
    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
            ];
           # gtkUsePortal = true;
        };
    };

    # Nix settings, auto cleanup and enable flakes
    nix = {
        settings.auto-optimise-store = true;
        settings.allowed-users = [ "notus" ];
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

    # Boot settings: clean /tmp/, latest kernel and enable bootloader
    boot = {
        
        loader = {
        systemd-boot.enable = true;
        systemd-boot.editor = true;
        efi.canTouchEfiVariables = true;
        timeout = 3;
        };
    };

    # Set up locales (timezone and keyboard layout)
    time.timeZone = "Asia/Karachi";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    # Set up user and enable sudo
    users.users.notus = {
        isNormalUser = true;
        extraGroups = [ "input" "wheel" ];
        shell = pkgs.fish;
    };
      users.users.pwn = {
    isNormalUser = true;
initialPassword = "pwn1";
    description = "pwn";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "input" "video"];
 
    packages = with pkgs; [
     
      kate
      fish
    #  thunderbird
    ];
  };

    # Set up networking and secure it
    networking = {
        wireless.iwd.enable = true;
        firewall = {
            enable = true;
            allowedTCPPorts = [ 443 80 ];
            allowedUDPPorts = [ 443 80 44857 ];
            allowPing = false;
        };
    };

    # Set environment variables
    environment.variables = {
        #NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
        #NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
        #XDG_DATA_HOME = "$HOME/.local/share";
        #PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
       # GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
        #GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
        #MOZ_ENABLE_WAYLAND = "1";
        #ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
       # EDITOR = "nvim";
       # DIRENV_LOG_FORMAT = "";
        #ANKI_WAYLAND = "1";
       # DISABLE_QT5_COMPAT = "0";
    };

    # Security 
    security = {
        sudo.enable = true;
        doas = {
            enable = true;
            extraRules = [{
                users = [ "pwn" "notus" ];
                keepEnv = true;
                persist = true;
            }];
        };

        # Extra security
        protectKernelImage = true;
    };

    # Sound
    sound = {
        enable = true;
    };

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };
    
    # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
    hardware = {
        bluetooth.enable = true;
        opengl = {
            enable = true;
            driSupport = true;
        };
    };
networking.networkmanager.enable = true;
programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable patching wlroots for better Nvidia support
   # enableNvidiaPatches = true;
  };
imports = [
./hardware-configuration.nix
];

    # Do not touch
    system.stateVersion = "23.05";
}
