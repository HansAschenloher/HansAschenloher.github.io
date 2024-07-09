{
  description = "nix devshell example";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; };

  outputs = { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux" # 64bit AMD/Intel x86
      ];

      forAllSystems = fn:
        nixpkgs.lib.genAttrs allSystems
        (system: fn { pkgs = import nixpkgs { inherit system; }; });

    in {
      # nix develop <flake-ref>#<name>
      # --
      # $ nix develop <flake-ref>#first
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          name = "nix";
          nativeBuildInputs = [ pkgs.jekyll pkgs.bundler ];
        };
      });
    };
}

