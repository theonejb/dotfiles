# ~/.config/nix/flake.nix

{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-zellij.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
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
      nixpkgs-zellij,
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
            # Other dev utils
            nixpkgs-zellij.legacyPackages.aarch64-darwin.zellij
            pkgs.direnv
            pkgs.git-lfs
            pkgs.terraform
            pkgs.awscli2
            pkgs.watchman
            pkgs.nixfmt-rfc-style
            pkgs.gh
            pkgs.ast-grep
            pkgs.act # Github actions local
            pkgs.starship
            pkgs.zoxide
            pkgs.jujutsu
            pkgs.httpie
            pkgs.imagemagick
            # For Lazyvim
            pkgs.neovim
            pkgs.lazygit
            pkgs.fzf
            pkgs.ripgrep
            pkgs.fd
            # Mac Apps
            pkgs.rectangle
            pkgs.obsidian
            pkgs.vscode
            pkgs.zoom-us
            pkgs.utm # Virtual Machines
            pkgs.terminal-notifier
          ];

          homebrew = {
            enable = true;
            onActivation = {
              cleanup = "none"; # Prevent nix-darwin emitting the disabled --cleanup
              extraFlags = [ "--force-cleanup" ];
            };

            # Homebrew 7 requires third-party taps to be explicitly trusted.
            # nix-darwin does not yet expose the Brewfile `trusted` tap option.
            extraConfig = ''
              tap "stripe/stripe-cli", trusted: true
              tap "ampcode/tap", trusted: true
            '';

            brews = [
              # Needed to install Ruby using Mise
              "libyaml"
              "flyctl"
              # Installed via brew to get the latest version
              "mise"
              "mosh"
              "mkcert"
              "herdr"
              "stripe/stripe-cli/stripe"
              "ampcode/tap/ampcode"
              "helix"
            ];

            casks = [
              "ghostty"
              "kitty"
              "orbstack"
              "scroll-reverser"
              "todoist-app"
              "pdf-expert"
              "httpie-desktop"
              "localsend"
              "ungoogled-chromium" # Not available as a nixpkg
              "handy" # Speech to text
              "session-manager-plugin"
              "mongodb-compass"
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
