{
	description = "My NixOS flake";


	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        mango = {
            url = "github:mangowm/mango";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        #musnix = {
            #url = "github:musnix/musnix";
            #inputs.nixpkgs.follows = "nixpkgs";
        #};

		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";

		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, mango, home-manager, ... }:
	{
		nixosConfigurations.nixos =
			nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";

				modules = [
					./configuration.nix
                    mango.nixosModules.mango
                    #musnix.nixosModules.musnix
					home-manager.nixosModules.home-manager

					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.oliver = import ./home.nix;
                        home-manager.extraSpecialArgs = {
                            inherit nixpkgs-unstable;
                        };
                        #home-manager.backupFileExtension = "backup";
					}
				];
			};
	};
}
