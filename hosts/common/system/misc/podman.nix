{
  ...
}:
let
  registries = [
    "docker.io"
    "ghcr.io"
    "quay.io"
  ];
in {
virtualisation = {
  containers.enable = true;

  # The module default for registries.settings is a bare list of [[registry]]
  # entries with no unqualified-search-registries, so podman cannot resolve any
  # short name: `"hashicorp/terraform-mcp-server" did not resolve to an alias`.
  # permissive short-name-mode keeps non-interactive pulls (MCP servers, CI)
  # from blocking on the registry-choice prompt.
  containers.registries.settings = {
    unqualified-search-registries = registries;
    short-name-mode = "permissive";
    registry = map (location: { inherit location; }) registries;
  };

  podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true; 
  };  
};

}
