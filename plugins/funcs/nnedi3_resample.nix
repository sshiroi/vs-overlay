{ lib, mkVapoursynthPythonSinglefileFunc, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:

mkVapoursynthPythonSinglefileFunc rec {
  pname = "nnedi3_resample";
  version = "unstable-2022-11-25";
  importname = "nnedi3_resample";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "eb53450a19f41f8435f36099f083ede0ae836c83";
    sha256 = "sha256-eoGbzhMu2D2g7Z/Es5Nx4x6K0Lg1a7jbSvR2q8WpowE=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    fmtconv
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    mvsfunc
    nnedi3
  ];

  meta = with lib; {
    description = "A VapourSynth script for easy resizing using nnedi3/znedi3/nnedi3cl with center alignment and correct chroma placement";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/nnedi3_resample";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
