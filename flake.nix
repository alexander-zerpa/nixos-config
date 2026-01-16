{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    autofirma-nix.url = "github:nix-community/autofirma-nix";
    autofirma-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, sops-nix, disko, autofirma-nix }: {
    nixosConfigurations = {
      hppc = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/hppc
          sops-nix.nixosModules.sops
          disko.nixosModules.disko
          ./hosts/hppc/disko.nix
          autofirma-nix.nixosModules.default
          ({pkgs, config, ... }: {
            programs.autofirma.enable = true;
            programs.autofirma.firefoxIntegration.enable = true;

            programs.configuradorfnmt.enable = true;
            programs.configuradorfnmt.firefoxIntegration.enable = true;
          })
        ];
      };
      nixos-vm = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/nixos-vm
          sops-nix.nixosModules.sops
          disko.nixosModules.disko
          ./hosts/nixos-vm/disko.nix
        ];
      };
      zaleos = nixpkgs.lib.nixosSystem {
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
