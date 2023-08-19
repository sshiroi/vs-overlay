{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-deband";
  version = "git-unstable";
  importname = "vsdeband";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "6c425949d6fbce3c88e55cdf22823253ef74ed4d";
    sha256 = "OqvO7zf1ukVWLcSRLbY20AYsmLOakepRdwYD8Vum64Q=";
  };

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

  doCheck = false;

  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-deband";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
