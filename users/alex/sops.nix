{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ];

  sops.secrets = {
    alex-password = {
      neededForUsers = true;
      sopsFile = ./secrets.yaml;
    };
    alex-ssh = {
      path = "${config.users.users.alex.home}/.ssh/id_ed25519";
      mode = "0600";
      owner = config.users.users.alex.name;
      sopsFile = ./secrets.yaml;
    };
  };
  system.activationScripts = {
    ssh-pub.text = "${pkgs.openssh}/bin/ssh-keygen -f ${config.sops.secrets.alex-ssh.path} -y > ${config.users.users.alex.home}/.ssh/id_ed25519.pub";
  };
}
