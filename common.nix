  final: prev:
  let
  # This is required to allow vapoursynth.withPlugins to be used inside python packages,
  # where normally python3Packages.vapoursynth would be used,
  # which only includes the python module without the frameserver.
  callPythonPackage = prev.lib.callPackageWith (final // final.vapoursynth.python3.pkgs // {
    inherit (final) vapoursynth;
  });

  filter_python_plugins = plugins: (builtins.filter (a: !(builtins.hasAttr "isBuildPythonPackage" a.meta)) plugins);

  generate_stubs = plg: let
    vap = final.vapoursynth.withPlugins plg;
  in
    final.vapoursynth.python3.pkgs.buildPythonPackage {
      name = "vapoursynth-stubs";
      format = "other";
      phases = [ "buildPhase" "installPhase" ];

      nativeBuildInputs = [
        vap.python3
        (callPythonPackage ./tools/vsstubs { })
        #(callPythonPackage ./tools/vsstubs { vapoursynth = vap; })
        vap
      ];

      buildPhase = ''
      PYTHONPATH=${vap}/${vap.python3.sitePackages}:$PYTHONPATH
      python -m vsstubs install test
      '';

      installPhase = ''
      install -D /build/vapoursynth.pyi $out/${vap.python3.sitePackages}/vapoursynth.pyi
      '';
    };

in rec {
  inherit generate_stubs filter_python_plugins callPythonPackage;
}