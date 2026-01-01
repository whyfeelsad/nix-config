{
  lib,
  config,
  ...
}: let
  cfg = config.services'.dae;
in {
  options.services'.dae = {
    enable = lib.mkEnableOption "Enable Dae service";
  };

  config = lib.mkIf cfg.enable {
    system.activationScripts.dae-initial-config = {
      text = ''
        if [ ! -e /etc/dae/config.dae ]; then
          mkdir -p /etc/dae
          cat > /etc/dae/config.dae <<EOF
        global{}
        routing{}
        EOF
          chmod 600 /etc/dae/config.dae
        fi
      '';
    };

    services.dae = {
      enable = true;
      configFile = "/etc/dae/config.dae";
    };

    preservation'.os.directories = [
      "/etc/dae/"
    ];
  };
}
