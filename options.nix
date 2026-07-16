{pkgs, lib, ...}:
{
  options = {
    enableSway = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    isWork = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    isDeploy = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
