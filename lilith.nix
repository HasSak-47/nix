{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/lilith";
  home.username = "lilith";
  home.stateVersion = "24.05";

  # man I hate fish
  programs.bash = {
    enable = true;
    initExtra = ''
        fish
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting 
    '';
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

  programs.waybar = {
    enable = true;
	systemd = {
	  enable = true;
	};
	settings = {
	  mainBar = {
	    modules-right  = ["wireplumber" "backlight" "cpu" "memory" "network"];
	    modules-left   = ["sway/workspaces" "sway/mode"];
	    modules-center = [];
	  };
	};
  };

  home.packages = with pkgs; [
    # utils
    w3m
    fish
    kitty
    zip
    bat

    # compile/runtime
    gnumake
    cargo
    rustc
    python3
    gcc
    go

    # tools
    rust-analyzer
    clang-tools
    valgrind
    nixd

    #wirebar
    pipewire
    wireplumber
  ];

  home.keyboard.layout  = "la-latin1";
  home.keyboard.options = ["la-latin1"];

  wayland.windowManager.sway = {
    systemd.enable = true;
    enable = true;
    config = {
      terminal = "kitty";
      modifier = "Mod4";
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
