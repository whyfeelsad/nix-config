{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
  };

  preservation'.os.directories = [
    {
      directory = "/var/lib/sops-nix";
      mode = "0700";
      inInitrd = true;
    }
  ];

  environment = {
    systemPackages = with pkgs; [
      sops
    ];
    sessionVariables = {
      SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/key.txt";
    };
  };
}
