{ config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "Oliver Grimm";
				email = "olivergrimm@fastmail.fm";
			};
			alias = {
				lg = "log --oneline --graph";
			};
		};
	};
}
