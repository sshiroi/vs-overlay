{ lib
, buildPythonPackage
, fetchFromGitHub
, runCommand
, makeWrapper

, psutil
, pyqt6
, pyqt6-sip
, qdarkstyle
, setuptools
, requests
, requests-toolbelt
, numpy
, pyyaml
, vapoursynth
, vapoursynthPlugins
, pyfftw
, python_call
, opencv4
, matplotlib
}:
let
  unwrapped = buildPythonPackage rec {
    pname = "vs-preview";
    version = "unstable";

    src = fetchFromGitHub {
      owner = "Irrational-Encoding-Wizardry";
      repo = "vs-preview";
      rev = "a2c05b2a2851df6e1bfb517f00d46d1090c86e08";
      sha256 = "7Tf3MFVisT2QDNq6I4Pfts8AYrM2e+UGwUZUzNR3MBM=";
    };

    postPatch = ''
      substituteInPlace requirements.txt \
          --replace "VapourSynth>=63" ""
    '';

    propagatedBuildInputs = [
      vapoursynth
      vapoursynthPlugins.vs-tools
      (python_call ./cueparse.nix {})
      (python_call ./pysubs2.nix {})
      (python_call ./vs_engine.nix {})
      psutil
      pyqt6
      pyqt6-sip
      pyyaml
      qdarkstyle
      setuptools
      requests
      requests-toolbelt
      numpy
      pyfftw
      opencv4
      matplotlib
    ];

    preIntall = ''
      export PYTHONPATH=$out/${vapoursynth.python3.sitePackages}:$PYTHONPATH
    '';
    checkPhase = ''
      export PYTHONPATH=$out/${vapoursynth.python3.sitePackages}:$PYTHONPATH
    '';

#  postInstall = ''
#    wrapProgram $out/bin/vspreview \
#        --prefix PYTHONPATH : $out/${vapoursynth.python3.sitePackages}
#  '';

    meta = with lib; {
      description = "Standalone previewer for VapourSynth scripts";
      homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-preview";
      license = licenses.asl20;
      maintainers = with maintainers; [  ];
    };
  };
  withPlugins = plugins: let
      vapoursynthWithPlugins = vapoursynth.withPlugins plugins;
    in runCommand "${unwrapped.name}-with-plugins" {
      buildInputs = [ makeWrapper ];
      passthru = { withPlugins = plugins': withPlugins (plugins ++ plugins'); };
    } ''
      #makeWrapper does not work because its already wrapped
      mkdir -p $out/bin
      echo "#!/usr/bin/env sh" > $out/bin/vspreview
      echo "export PYTHONPATH=\"\$PYTHONPATH:${vapoursynthWithPlugins}/${vapoursynth.python3.sitePackages}\"" >> $out/bin/vspreview
      echo "export LD_LIBRARY_PATH=\"\$LD_LIBRARY_PATH:${vapoursynthWithPlugins}/lib\""  >> $out/bin/vspreview
      echo "${unwrapped}/bin/vspreview \"\$@\""   >> $out/bin/vspreview
      chmod +x  $out/bin/vspreview
     '';
in
  withPlugins (with vapoursynthPlugins; [
    vsutil
    descale
    ffms2
    fmtconv
    mvtools
    placebo
    miscfilters-obsolete
    vs-dfft
    libp2p
  ])
