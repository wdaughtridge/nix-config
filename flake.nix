{
  description = "A very basic flake";
  outputs = { nixpkgs, ... }:
  let pkgs = nixpkgs.legacyPackages.aarch64-darwin; in
  {
    devShells.aarch64-darwin.default = pkgs.mkShell {
      buildInputs = [
        pkgs.nixpkgs-fmt
      ];
      packages = [ pkgs.lazygit ];
      shellHook = ''
        echo 'hello!!'
      '';
    };
  };
}
