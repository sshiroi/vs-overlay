{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-denoise";
  version = "git-unstable";
  importname = "vsdenoise";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "a54089207a5a42cabbc6eebc1c3d753f31faf995";
    sha256 = "H8PbKtn90WkGilLm7IOUQmSESVgECAk7p3O6o8c8D9c=";
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

  doCheck = false;
  meta = with lib; {
    description = "VapourSynth denoising, regression, and motion-compensation functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-denoise";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}