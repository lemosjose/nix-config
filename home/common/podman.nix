{
  pkgs,
  ...
}:
let
  registries = [
    "docker.io"
    "ghcr.io"
    "quay.io"
  ];
in {
# kiro-fhs and vscode.fhsWithPackages both run under buildFHSEnv, whose /etc is
# a fixed whitelist that does not include containers/. So podman started from
# inside either editor (MCP servers, tasks, terminals) sees no registry list and
# no trust policy at all -- kiro's terraform MCP server cannot resolve the
# hashicorp/terraform-mcp-server short name for exactly this reason.
# Rootless podman reads these from $HOME first, and $HOME *is* passed through.
xdg.configFile = {
  "containers/registries.conf".source =
    (pkgs.formats.toml { }).generate "registries.conf" {
      unqualified-search-registries = registries;
      short-name-mode = "permissive";
    };

  "containers/policy.json".text = builtins.toJSON {
    default = [ { type = "insecureAcceptAnything"; } ];
    transports.docker-daemon."" = [ { type = "insecureAcceptAnything"; } ];
  };
};

}
