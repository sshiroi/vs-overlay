{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-dehalo";
  version = "git-unstable";
  importname = "vsdehalo";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "197ed286fbe800e762ecf51d040d8c434c204384";
    sha256 = "tJ0CyvCOKgynhg+M2kFE/eTN+X4c3ymnYu8jVq+m0PU=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vsmask
    vs-aa
    vs-scale
    vs-denoise
  ];

  vs_binarydeps = [ ];

  doCheck = false;

  meta = with lib; {
    description = "Collection of dehaloing VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-dehalo";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
