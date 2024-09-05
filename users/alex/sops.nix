{ config, pkgs, ... }:

{
  import =
    [
    ];

  sops.secrets
    alex-password = {
      neededForUsers = true;
      sopsFile = ./secrets.yaml;
    };
    alex-ssh = {
      path = "/home/alex/.ssh/id_ed25519";
      mode = "0600";
      owner = config.users.users.alex.name;
      sopsFile = ./secrets.yaml;
    };
  };
}
