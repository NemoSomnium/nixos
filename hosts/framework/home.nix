{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "noams";
  home.homeDirectory = "/home/noams";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Configuring fonts
  fonts.fontconfig.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
    ripgrep # Necessary for nvim
    wl-clipboard # Necessary for enabling nvim clipboard
    lunarvim
    sqlite # Necessary for emacs org-mode roam
    libvterm # Dependency for vterm
    ispell
    python3
    python312Packages.pyasyncore # Possible dependency for playonlinux
    pyright
    jetbrains.pycharm-community
    neofetch
    git
    lazygit
    _1password
    _1password-gui
    master.teams-for-linux
    portal
    fzf
    thefuck
    bat
    btop
    lan-mouse
    putty
    zoxide
    libreoffice-fresh
    vesktop
    obsidian
    master.vmware-workstation
    bottles
    playonlinux
    alacritty-theme
    warp-terminal
    tldr
    unzip
    eza
    wireshark-qt
    culmus # Hebrew fonts
    (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" ]; })
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  
  # zsh settings
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man" "zoxide" "zsh-interactive-cd" "fzf" "thefuck" ];
      theme = "candy-kingdom"; 
      };
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -lh --icons";
      la = "eza -lah --icons";
      tree = "eza --header --tree --icons";
      gittree = "eza --long --header --icons --git --tree";
      lg = "lazygit";
      nvim = "lvim";
      vim = "lvim";
      vi = "lvim";
      lv = "lvim";
      inv = "lvim $(fzf -m --preview='bat --color=always {}')";
      fkill = "fzf-kill.sh";
    };
    initExtra = ''
      export SSH_AUTH_SOCK=${config.home.homeDirectory}/.1password/agent.sock
      export PATH="$HOME/scripts:$PATH"
      export PATH="$HOME/.emacs.d/bin:$PATH"
      eval $(thefuck --alias)
      export MANPAGER="lvim -c 'set ft=man' -c 'Man!' -"
    '';
  };

  # Alacritty settings
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "{$pkgs.alacritty-theme}/dracula.yml"
      ];
      # Other alacritty settings go here
    };
  };

  # Emacs settings
  programs.emacs = {
    enable = true;
    extraConfig = ''
      (add-to-list 'default-frame-alist '(fullscreen . maximized))
    '';
    extraPackages = epkgs: with epkgs; [
      vterm
    ];
  };


    
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/noams/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtPluginPrefix}";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH";
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";
    FLAKE = "/home/noams/nixos";
    # MANPAGER = "lvim -c 'set ft=man' -c 'Man!' -"; # Set lvim as default MANPAGER
    #SHELL = "${pkgs.zsh}/bin/zsh";
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
