{nixpkgs, flake-utils, ...}:
let
  pkgs = nixpkgs.legacyPackages.${system};
in
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      go-task
      alejandra
      jq
    ];
  };
}
