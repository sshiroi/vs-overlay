{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-dehalo";
  version = "git-1.5.0";
  importname = "vsdehalo";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "12924441ad1cb247397cf2b68d1039567d77345a";
    sha256 = "sha256-hYv0w0xgVb9lO+Qjy88MStNGZ2deVN7Ab2YBfPW4TXI=";
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
