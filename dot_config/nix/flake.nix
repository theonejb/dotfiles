# ~/.config/nix/flake.nix

{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility. please read the changelog
          # before changing: `darwin-rebuild changelog`.
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          # If you're on an Intel system, replace with "x86_64-darwin"
          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.config.allowUnfree = true;

          # Declare the user that will be running `nix-darwin`.
          users.users.jibran = {
            name = "jibran";
            home = "/Users/jibran";
          };
          system.primaryUser = "jibran";

          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh.enable = true;

          security.pam.services.sudo_local.touchIdAuth = true;

          environment.systemPackages = [
            # Mise dev env manager
            pkgs.mise
            # Other dev utils
            pkgs.zellij
            pkgs.direnv
            pkgs.devenv
            pkgs.git-lfs
            pkgs.terraform
            pkgs.awscli2
            pkgs.watchman
            # nixfmt ; mostly for nvim
            pkgs.nixfmt-rfc-style
            # For Lazyvim
            pkgs.neovim
            pkgs.lazygit
            pkgs.fzf
            pkgs.ripgrep
            pkgs.fd
            # Langs
            pkgs.zulu17
            # Mac Apps
            pkgs.rectangle
            pkgs.obsidian
            pkgs.vscode
            pkgs.zoom-us
          ];

          homebrew = {
            enable = true;
            onActivation.cleanup = "uninstall";

            taps = [ ];

            brews = [
              # Needed to install Ruby using Mise
              "libyaml"
            ];

            casks = [
              "ghostty"
              "orbstack"
              "scroll-reverser"
              "todoist-app"
              "pdf-expert"
              "httpie-desktop"
              "localsend"
              # Already installed in current setup but leaving
              # here for next time
              # "1password"
              # "whatsapp"
              # "setapp"
            ];
          };

          fonts.packages = [
            pkgs.nerd-fonts.jetbrains-mono
          ];
        };
    in
    {
      darwinConfigurations."jibran-mba" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
        ];
      };
    };
}
