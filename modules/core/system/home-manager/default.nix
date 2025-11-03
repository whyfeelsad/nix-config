{
  lib,
  inputs,
  system,
  config,
  options,
  ...
}:
let
  inherit (config.globals) userName homeDirectory;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options = {
    hm' = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Options to pass directly to home-manager primary user.";
    };
    user' = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Options to pass directly to users.extraUsers primary user.";
    };
  };

  config = {
    user'.home = homeDirectory;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = false;
      backupFileExtension = "hm-bak";
    };

    hm' = {
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      home.username = userName;
      home.homeDirectory = homeDirectory;
      # TODO: programs.home-manager.enable should add this pkg
      home.packages = [ inputs.home-manager.packages.${system}.default ];
    };

    # hm'-> home-manager.users.<primary user>
    home-manager.users.${userName} = lib.mkAliasDefinitions options.hm';
    # user' -> users.extraUsers.<primary user>
    users.extraUsers.${userName} = lib.mkAliasDefinitions options.user';
  };
}
