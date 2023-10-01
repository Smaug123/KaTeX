{
    description = "KaTeX flake";
    inputs = {
        flake-utils.url = "github:numtide/flake-utils";
        nixpkgs.url = "github:NixOS/nixpkgs//nixos-22.11";
    };

    outputs = {
        self,
        nixpkgs,
        flake-utils,
    }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    {
        packages.default = (import ./default.nix) { inherit pkgs; };
        packages.fonts = pkgs.stdenv.mkDerivation {
            __contentAddressed = true;
            pname = "katex-fonts";
            version = "0.1.0";
            src = ./fonts;
            installPhase = ''
              mkdir -p "$out"
              cp -r ./. $out
            '';
        };
    }
    );
}
