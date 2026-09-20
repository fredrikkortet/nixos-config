{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent = {
    enable = true;
  };

  services.hermes-agent = {
    enable = true;
    gateway.enable = true;
    settings.model.default = "inclusionai/ling-3.0-flash-fin:free";
    environmentFiles = [
      config.sops.secrets.hermes_env.path
    ];
  };
}
