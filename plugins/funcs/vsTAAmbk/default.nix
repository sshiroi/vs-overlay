{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, fetchpatch, vapoursynthPlugins,   }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "vsTAAmbk";
  #version = ">0.8.1";
  version = "unstable-22-12-11";
  importname = "vsTAAmbk";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "c707f5a8178b80e3ddc4556b69dd36c0d1928166";
    sha256 = "sha256-GD8/NPE9XMvTqyko5HP778/ymjmFTzj1M/VTtEl4JTg=";
  #  rev = "v${version}";
  #  sha256 = "sha256-KfU2f7tBhw007f4RmVruV3Pkgo1zdA4o43+1lL/ohKo=";
  };

  patches = [
    ./0001-Skip-OpenCL-test.patch
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    awarpsharp2
    cas
    eedi2
    eedi3m
    fmtconv
    msmoosh
    mvtools
    nnedi3
    nnedi3cl
    removegrain
    sangnom
    tcanny
    znedi3
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    mvsfunc
    havsfunc
  ];

  checkPhase = ''
    python3 test/vsTAAmbkTestCase.py
  '';

  meta = with lib; {
    description = "An Anti-aliasing script for VapourSynth ported from Avisynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/vsTAAmbk";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
