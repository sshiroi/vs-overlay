{ lib, fetchFromGitHub, mkVapoursynthPythonSinglefileFunc, python, vapoursynthPlugins, vapoursynth }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "astdr";
  version = "4";
  importname = "ASTDR";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = "vapoursynth-astdr";
    rev = "v${version}";
    sha256 = "sha256-We3vhTZCGYZPMOAfWGif3yAxBUAPUk9zm9JQdlWhn8E=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    awarpsharp2
    fft3dfilter
    hqdn3d
    mvtools
    ctmf
    fluxsmooth
    decross
    temporalsoften2
    motionmask
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    adjust
  ];

  meta = with lib; {
    description = "A VapourSynth derainbow function";
    homepage = "https://github.com/dubhater/vapoursynth-astdr";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}