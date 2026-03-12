{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.theme.colorscheme;
  hexColorType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && !(hasPrefix "#" x);
  };
in
{
  options.theme.colorscheme = {
    enable = mkEnableOption "Base16 color theme";

    scheme = mkOption {
      type = with types; attrsOf (coercedTo str (removePrefix "#") hexColorType);
      description = "Base16 color scheme";
      default = { };
    };
  };

  config = mkIf cfg.enable {

    # Export palette globally so other modules can use it
    _module.args.colorscheme = cfg.scheme;

  };
}
