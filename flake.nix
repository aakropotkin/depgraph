{
  description = "A dependency graph visualizer.";

  #inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.ak-core.url = "github:aakropotkin/ak-core";

  outputs = { self, nixpkgs, ak-core }: {

    overlays.depgraph = import ./overlay.nix;
    overlay = self.overlays.depgraph;

    packages.x86_64-linux.depgraph = ( import nixpkgs {
      sys = "x86_64-linux";
      overlays = [self.overlay ak-core.overlay];
    } ).depgraph;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.depgraph;
    nixosModules.depgraph = { pkgs, ... }: {
      nixpkgs.overlays = [self.overlay];
    };
    nixosModule = self.nixosModules.depgraph;
  };
}
