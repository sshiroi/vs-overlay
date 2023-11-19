{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-aa";
  version = "git-unstable";
  importname = "vsaa";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "e822da4a1407bc74ee3546250f9c579afd03856e";
    sha256 = "sha256-Lmv5gIyXaPSaju4ufZeSWVxvz6Siv2bFPvRieLPBFWo=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vsutil
    vsmask
    vs-kernels
    vs-exprtools
    vs-rgtools
    vs-masktools
  ];

  vs_binarydeps = [];

  meta = with lib; {
    description = "anti aliasing and scaling functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-aa";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
