{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, sops-nix, disko }: {
    nixosConfigurations = {
      nixos-vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/nixos-vm
          sops-nix.nixosModules.sops
          disko.nixosModules.disko
          ./hosts/nixos-vm/disko.nix
        ];
      };
      nixos-vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/zaleos
          sops-nix.nixosModules.sops
          disko.nixosModules.disko
          ./hosts/zaleos/disko.nix
        ];
      };
    };

    packages.x86_64-linux.disko = disko.packages.x86_64-linux.disko;
    packages.x86_64-linux.disko-install = disko.packages.x86_64-linux.disko-install;
  };
}
