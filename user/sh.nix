{ config, pkgs, ... }:

let
	myAliases = {
		ls = "eza";
		ll = "ls -alF";
		va = "cd ~/.wine/drive_c/VASP";
	};
in
{
	programs.bash = {
		enable = true;
		shellAliases = myAliases;
		initExtra = ''
			export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
		'';
	};
}
