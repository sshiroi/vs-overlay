{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-aa";
  version = "git-1.6.0";
  importname = "vsaa";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "34abd260a3c341a7669db5616508ef0f23340464";
    sha256 = "sha256-RqL6sr2qP+sCI8OgajPpkdR/eiaB0JnEWbEuIZE9KZ0=";
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

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "anti aliasing and scaling functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-aa";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
