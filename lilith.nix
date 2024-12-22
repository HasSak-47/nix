{ config, pkgs, ... }:

{
  #allow non free pkgs
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" ];

  home.homeDirectory = "/home/lilith";
  home.username = "lilith";
  home.stateVersion = "24.05";

  programs.nushell = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 10;
    };
    settings = { };
    extraConfig = "background_opacity 0.8";
  };


  home.packages = with pkgs; [
    # utils
    w3m
    nushell
    kitty
    zip
    spectacle
    bat
    cloc
    tmux
    tree

    # compile/runtime
    gnumake
    cargo
    rustc
    python3
    gcc
    go
    typescript

    # tools
    neovim
    rust-analyzer
    clang-tools
    valgrind
    sccache
    pyright
    nixd
    zig
    tree-sitter
    glfw
    docker
    podman
    docker-compose
    podman-compose
    dive


    #hate lsp
    vscode-langservers-extracted
    # nodePackages.vscode-html-languageserver-bin
    # nodePackages.vscode-css-languageserver-bin
    # nodePackages.coc-sumneko-lua
    # nodePackages.typescript-language-server

    #man
    man-pages
    man-pages-posix

    #wirebar
    pipewire
    wireplumber
    helvum
    pulseaudio

    # git neofetch that looks sick af
    onefetch

    kdePackages.breeze-gtk
    kdePackages.breeze

    #temp while daniel is dead
    obsidian
    obs-studio
  ];

  home.keyboard.layout  = "la-latin1";
  home.keyboard.options = ["la-latin1"];

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      mainBar = {
        modules-right  = ["wireplumber" "backlight" "cpu" "memory" "network" "clock"];
        modules-left   = ["sway/workspaces" "sway/mode"];
        modules-center = [];
      };
    };
  };

  programs.ssh.enable = true;
  services.ssh-agent.enable = true;
  systemd.user.startServices = "sd-switch";

  wayland.windowManager.sway = {
    systemd.enable = true;
    enable = true;
    config = {
      terminal = "kitty";
      modifier = "Mod4";
      window = {
        titlebar = false;
        border = 2;
      };
      startup = [
        { command = "kitty"; }
      ];
      bars = [];
      gaps.outer = 10;
    };

    # keybinds has it's own option dumbass
    extraConfig = ''
      input * {
        xkb_layout "latam"
      }
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10
      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
    '';
  };
}
