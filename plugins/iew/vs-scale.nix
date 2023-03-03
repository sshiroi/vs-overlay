{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-scale";
  version = "git-1.7.0";
  importname = "vsscale";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "73301a0b07a515f7815e0de9ddf80ec52af01914";
    sha256 = "sha256-KRICog02Rguc3tnYfKyZU7H+QJmmMsIQR0roVNBCXc8=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-aa
    vsmask
  ];
  vs_binarydeps = [];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "Wrappers for scaling and descaling functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-scale";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
