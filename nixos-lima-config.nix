{ config, modulesPath, pkgs, lib, nixos-lima,... }:
{
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
      nixos-lima.nixosModules.lima
    ];

    networking.hostName = "nixsample";

    services.lima.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.openssh.enable = true;

    security = {
        sudo.wheelNeedsPassword = false;
    };

    boot.loader.grub = {
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
    };
    fileSystems."/boot" = {
        device = lib.mkForce "/dev/vda1";  # /dev/disk/by-label/ESP
        fsType = "vfat";
    };
    fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        autoResize = true;
        fsType = "ext4";
        options = [ "noatime" "nodiratime" "discard" ];
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    environment.systemPackages = with pkgs; [
        vim
    ];

    system.stateVersion = "25.11";
}
