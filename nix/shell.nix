{
  inputs,
  pkgs,
  rustVersion,
  ...
}:
inputs.devenv.lib.mkShell {
  inherit inputs pkgs;
  modules = [
    {
      packages = with pkgs; [
        (rustVersion.override {
          extensions = [
            "clippy"
            "rust-src"
            "rust-analyzer"
            "rustfmt"
          ];
        })
        bacon
      ];
    }
  ];
}
