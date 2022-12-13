{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-deband";
  #version = "0.6.1";
  version = "unstable-2022-12-13";
  importname = "vsdeband";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "fa219f25128d8e7bb2cec867272507a5464cda66";
    sha256 = "sha256-B2ZAdh/8Ec8rRCENVjOi5X893swbjSCfKu8aQ7rcvbQ=";
  };

  remove_vapoursynth_dep_reqtxt = 59;

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
    vs-rgtools
    vs-kernels
    vs-exprtools
    vsmask
    vs-scale

    vs-denoise#missing in requirements
  ];
  vs_binarydeps = [];


  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-denoise";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
