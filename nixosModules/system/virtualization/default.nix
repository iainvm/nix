{
  lib,
  pkgs,
  config,
  ...
}: {
  options.core.system.virtualization = {
    enable = lib.mkEnableOption "virtualization";
  };

  config = lib.mkIf config.core.system.virtualization.enable {
    systemd.tmpfiles.rules = ["L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"];

    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      libvirt
      qemu_kvm
      OVMF
      vagrant
      qemu
      swtpm
    ];
  };
}
