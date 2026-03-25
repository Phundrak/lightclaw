{
  pkgs,
  rustPlatform,
  ...
}: let
  cargoToml = fromTOML (builtins.readFile ../Cargo.toml);
  inherit (cargoToml.package) name version;
  rustBuild = rustPlatform.buildRustPackage {
    pname = name;
    inherit version;
    src = pkgs.lib.cleanSource ../.;
    cargoLock.lockFile = ../Cargo.lock;
    meta = {
      inherit (cargoToml.package) homepage description;
    };
    postBuild = "${pkgs.upx}/bin/upx target/*/release/${name}";
  };
in {
  default = rustBuild;
}
