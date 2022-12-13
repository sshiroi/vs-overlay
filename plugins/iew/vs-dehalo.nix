{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-dehalo";
  version = "1.2.0";
  importname = "vsdehalo";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    rev = "1415d481fbcf4e2d0fa1b3774984577b4cd0801d";
    sha256 = "sha256-7eRneoY2+jIjzB7mo4bYpIyKlwhjA+ztjVWW8GgJhRg=";
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

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "Collection of dehaloing VapourSynth functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-dehalo";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
