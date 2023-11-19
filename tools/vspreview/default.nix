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
, callPackage
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
      rev = "6d3415e4021d159c53be0ece6c1a407a7cfdc523";
      sha256 = "sha256-4wcdVINpPYE5z/V6VhX9UWV7t4mTltdfNjCDT7fGhUY=";
    };

    postPatch = ''
      substituteInPlace requirements.txt \
          --replace "VapourSynth>=63" ""
    '';

    propagatedBuildInputs = [
      vapoursynth
      vapoursynthPlugins.vs-tools
      (python_call ./cueparse.nix {})
      vapoursynthPlugins.vs-engine
      #(callPackage ./pysubs2.nix {})
     #(python_call ./vs_engine.nix {})
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
