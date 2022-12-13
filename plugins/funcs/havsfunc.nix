{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "havsfunc";
  version = "unstable-2022-09-08";
  importname = "havsfunc";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "2c6d3fedc3c4c3f3ed2460f7014d1227fe2fe207";
    sha256 = "sha256-YJl/X9niJelgovwUK6S50lvQUe/yYAbXEHWBbMqfXz0=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    adjust
    mvsfunc
    nnedi3_resample
    vsutil
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    addgrain
    bm3d
    cas
    ctmf
    dctfilter
    deblock
    dfttest
    eedi2
    eedi3m
    fft3dfilter
    fluxsmooth
    fmtconv
    fmtconv
    hqdn3d
    knlmeanscl
    miscfilters-obsolete
    mvtools
    nnedi3
    nnedi3cl
    sangnom
    ttempsmooth
    znedi3
  ];

  meta = with lib; {
    description = "Holy’s ported AviSynth functions for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/havsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
