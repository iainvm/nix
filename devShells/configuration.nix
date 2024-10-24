{
  system,
  inputs,
  ...
}: let
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
in {
  default = pkgs.mkShell {
    packages = [
      pkgs.git
      pkgs-unstable.go-task
      pkgs.alejandra
    ];
  };
}
