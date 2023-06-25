{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-deinterlace";
  version = "git-0.4.0";
  importname = "vsdeinterlace";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "5ccaf9f0e23362308b63e293534aeeda3a73b287";
    sha256 = "sha256-9LE2iHhSATsWDTvx04WkDzItzuD0GkFjcFp8I4Wezdg=";
  };

  vs_pythondeps = with vapoursynthPlugins;  [
    vs-tools
    vs-kernels
    vs-rgtools
    vs-denoise
  ];
  vs_binarydeps = with vapoursynthPlugins; [
    planestatsmod
  ];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "VapourSynth deinterlacing and interlaced/telecined content helper functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-deinterlace";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
