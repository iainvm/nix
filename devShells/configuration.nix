{
  system,
  inputs,
  ...
}: let
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  default = pkgs.mkShell {
    packages = [
      pkgs.git
      pkgs.go-task
      pkgs.alejandra
      pkgs.go-task
    ];
  };
}
