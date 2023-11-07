{ config, pkgs, inputs, ... }:

{
    # Remove unecessary preinstalled packages
    environment.defaultPackages = [ ];
    services.xserver.desktopManager.xterm.enable = false;
services.xserver.enable = true;
services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;
    #programs.fish.enable = true;
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.videoDrivers = [ "amdgpu" ]; # or appropriate video driver
  services.xserver.desktopManager.waylandSession.enable = true;



  services.swaybg.enable = true;
  services.swaybg.package = pkgs.swaybg;

  services.swaylock.enable = true;
  services.swaylock.package = pkgs.swaylock-effects;

  services.swayidle.enable = true;
  services.swayidle.package = pkgs.swayidle;

  services.grim.enable = true;
  services.grim.package = pkgs.grim;

  services.slurp.enable = true;
  services.slurp.package = pkgs.slurp;

  services.wl-clipboard.enable = true;
  services.wl-clipboard.package = pkgs.wl-clipboard;

  services.dunst.enable = true;
  services.dunst.package = pkgs.dunst;

  services.xdg-user-dirs.enable = true;
  services.xdg-user-dirs.package = pkgs.xdg-user-dirs;

  services.rofi.enable = true;
  services.rofi.package = pkgs.rofi-wayland;

  services.viewnior.enable = true;
  services.viewnior.package = pkgs.viewnior;

  services.eww.enable = true;
  services.eww.package = pkgs.eww-wayland;

  services.foot.enable = true;
  services.foot.package = pkgs.foot;

  services.nerd-fonts.enable = true;
  services.nerd-fonts.fonts = [ pkgs.jetbrainsMono ];

  services.zsh.enable = true;
  services.zsh.promptInit = lib.mkIf config.users.users.pwn.isCurrent true;

  services.starship.enable = true;
  services.starship.package = pkgs.starship;

  services.thunar.enable = true;
  services.thunar.package = pkgs.thunar;
  
  services.thunar.volumeManager.enable = true;
  services.thunar.archivePlugin.enable = true;
  services.gvfs.enable = true;

  services.file-roller.enable = true;
  services.file-roller.package = pkgs.gnome.file-roller;

  services.gsettings-desktop-schemas.enable = true;
  services.lxappearance.enable = true;
  services.lxappearance.package = pkgs.lxappearance;

  services.kripton.enable = true;
  services.kripton.package = pkgs.kripton;

  #services.cursors.theme = "Qogir-cursors";

  services.playerctl.enable = true;
  services.playerctl.package = pkgs.playerctl;

  services.networkmanager.enable = true;
  services.polkit.enable = true;
  services.dbus.enable = true;

  services.brightnessctl.enable = true;
  services.brightnessctl.package = pkgs.brightnessctl;

  services.helix.enable = true;
  services.helix.package = pkgs.helix;
    # Laptop-specific packages (the other ones are installed in `packages.nix`)
    environment.systemPackages = with pkgs; [
        git
python2
rustup
kitty


 swayidle swaylock-effects grim slurp mako wl-clipboard chayang cliphist nwg-look swappy material-design-icons iosevka xdg-user-dirs noto-fonts-emoji libsForQt5.polkit-kde-agent clipman imagemagick hyprpicker gpick acpi libsForQt5.qt5ct spotify brightnessctl pamixer papirus-icon-theme
thunar 
 cava spicetify-cli
neofetch


networkmanager
networkmanagerapplet


blueman
bluez
waybar
bibata-cursors

swww
wlogout
pfetch
    ];

    # Install fonts
    fonts = {
        fonts = with pkgs; [
             iosevka
            jetbrains-mono
            noto-fonts-emoji
            openmoji-color
            ttf-firacode-nerd
            ttf-fira-code
            (nerdfonts.override { fonts = [ "jetbrains-mono" ]; })
        ];

        fontconfig = {
            hinting.autohint = true;
            defaultFonts = {
              emoji = [ "noto-fonts-emojir" ];
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
        shell = pkgs.zsh;
    };
      users.users.pwn = {
    isNormalUser = true;
initialPassword = "pwn1";
    description = "pwn";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "video"];
 
    packages = with pkgs; [
     
      kate
      zsh
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
    };
    
    # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
    hardware = {
        bluetooth.enable = true;
        opengl = {
            enable = true;
            driSupport = true;
        };
    };
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
