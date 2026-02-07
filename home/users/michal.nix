{ ... }: {
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.11";

  imports = [
    ../modules/zsh.nix
  ];
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;
}
