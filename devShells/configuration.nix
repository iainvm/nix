{
  system,
  nixpkgs,
  nixpkgs-unstable,
  ...
}: let
  pkgs = nixpkgs.legacyPackages.${system};
  pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
in {
  default = pkgs.mkShell {
    packages = [
      pkgs.git
      pkgs-unstable.go-task
      pkgs.alejandra
      pkgs.jq
    ];
  };
}
