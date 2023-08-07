nrk:
	nix build ~/dotfiles#darwinConfigurations.nrk.system
	make clean
	darwin-rebuild switch --flake ~/dotfiles#nrk

update:
	nix flake update

clean:
	rm -rf ~/.vscode/extensions

