{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko }: {
    nixosConfigurations = {
      nixos-vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/nixos-vm
          disko.nixosModules.disko
          ./hosts/nixos-vm/disko.nix
        ];
      };
    };

    packages.x86_64-linux.disko = disko.packages.x86_64-linux.disko;
    packages.x86_64-linux.disko-install = disko.packages.x86_64-linux.disko-install;
  };
}
