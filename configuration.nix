# Minimal configuration for OnePlus 6T (fajita) NixOS Mobile
# Focus on essentials: SSH, wireless, and basic tools

{ config, lib, pkgs, ... }:

{

  # Allow unfree packages (needed for OnePlus firmware)
  nixpkgs.config.allowUnfree = true;

  # Enable SSH server (essential for mobile device access)
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes"; # For initial setup
  services.openssh.settings.PasswordAuthentication = true; # For initial setup

  # Set root password for SSH access
  users.users.root.password = "nixtheplanet";

  # Minimal essential packages
  environment.systemPackages = with pkgs; [
    tmux
    neovim
    htop
    ripgrep
    firefox-mobile
  ];

  users.users."ms" = {
    isNormalUser = true;
    uid = 1000;
    # $ mkpasswd -m sha-512 "1234"
    hashedPassword = "$6$sOgSAU508LEA5V27$ELHRCBPBmrX0ltZWuZJeRh/hNUa7IsAmemehK3.KAel6JPKRwBRZf9n2nck4wOeLN8UiSw6p01eLaqrE6Oa9K1";
    extraGroups = [
      "dialout"
      "feedbackd"
      "networkmanager"
      "video"
      #"audio"
      "wheel"
    ];
  };

  time.timeZone = "Europe/Berlin";
  hardware = {
    enableRedistributableFirmware = true;
    graphics.enable = true;
    sensor.iio.enable = true;
  };

  programs.calls.enable = true;
  mobile.quirks.qualcomm.sdm845-modem.enable = true;
  mobile.quirks.audio.alsa-ucm-meld = true;
  mobile.beautification = {
    silentBoot = false;
    splash = true;
  };

  system.stateVersion = "25.11";
} 
