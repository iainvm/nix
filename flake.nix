{
  # github.com/iainvm/nix
  description = "My Nix config";

  # Dependencies
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
  };

  outputs = {self, nixpkgs, home-manager, ...}:
  {
    # Dev Shell for updating nix configs
    devShells."${system}".default = pkgs.mkShell {
      hardeningDisable = ["fortify"];
      packages = with pkgs; [
        go-task
        alejandra
        jq
      ];
    };
  };
}
