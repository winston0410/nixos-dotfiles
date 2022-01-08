# Commands

Switch generation

```sh
sudo nixos-rebuild switch --flake .#
```

Build host machine

```sh
sudo nixos-rebuild build --flake .#
```

Build virtual machine(e.g. k3s)

```sh
sudo nixos-rebuild build-vm --flake .#k3sVm
```
