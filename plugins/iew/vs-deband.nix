{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-deband";
  version = "git-0.9.0+1";
  importname = "vsdeband";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "ccdc6405d7144d4de651c9902618a68c3a7bee8c";
    sha256 = "sha256-AprFX3+VlWJaqwKgfM9UbAcGlI3ci9dS2ogj0s8u6x4=";
  };

  remove_vapoursynth_dep_reqtxt = 60;

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
    vs-rgtools
    vs-kernels
    vs-exprtools
    vsmask
    vs-scale

    vs-denoise#missing in requirements
  ];
  vs_binarydeps = with vapoursynthPlugins; [
    morpho
  ];


  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-denoise";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
