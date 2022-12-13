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
        (callPythonPackage ../tools/vsstubs { })
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

  old_glslang = prev.glslang.overrideAttrs (old: rec {
    version = "1.3.216.0";
    src = prev.fetchFromGitHub {
      owner = "KhronosGroup";
      repo = "glslang";
      rev ="sdk-${version}";
      hash = "sha256-sjidkiPtRADhyOEKDb2cHCBXnFjLwk2F5Lppv5/fwNQ=";
    };
  });
  #latest nixos-unstable has broken ncnn because some glslang update
  #then they fixed it, but now its broken again so this patch stays
  old_ncnn = prev.ncnn.override { glslang = old_glslang; };
in rec {
  inherit old_ncnn generate_stubs old_glslang filter_python_plugins callPythonPackage;
}