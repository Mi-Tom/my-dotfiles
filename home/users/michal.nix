{ ... }: {
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";

  imports = [
    ../modules/zsh.nix
  ];

  programs.home-manager.enable = true;
}
