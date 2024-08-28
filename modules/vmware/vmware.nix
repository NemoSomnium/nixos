{ config, pkgs, ... }:

{
  
  # Enable VMwarehost modules
  virtualisation.vmware.host.enable = true;
  virtualisation.vmware.host.package = pkgs.master.vmware-workstation;

  # Add necessary kernel modules
  boot.extraModulePackages = with config.boot.kernelPackages; [
    vmware
  ];

  # Add your user to the necessary groups
  users.users.noams = {
    extraGroups = [ "vmware" "disk" ];
  };

  # Add VMware Workstation to system packages if not set in home-manager
  #environment.systemPackages = with pkgs; [
  #  vmware-workstation
  #];
}
