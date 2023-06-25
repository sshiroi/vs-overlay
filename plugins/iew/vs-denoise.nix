{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-denoise";
  version = "git-unstrable";
  importname = "vsdenoise";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "fb853b2461c050de991b31d0c784462238c7c011";
    sha256 = "sha256-eRBW4A+s5jjQPE0zOUvsVpvcKXw/nJzkPlHSRb+4r54=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-aa
    vs-scale
  ];

  vs_binarydeps = [];

  remove_vapoursynth_dep_reqtxt = 60;
  doCheck = false;
  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-denoise";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}