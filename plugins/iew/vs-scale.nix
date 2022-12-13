{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-scale";
  #version = "1.2.0";
  version = "unstable-2022-11-26";
  importname = "vsscale";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    #rev = "v${version}";
    #sha256 = "sha256-X98x+Vjs9eGH7smtTaUsWHdWRfFJLasddsa9FYA8OQBh+BqA=";
    rev = "3e7aa2685fc1e2f3c717449e0971be85058c0a90";
    sha256 = "sha256-Q4IueAlNcQPKCi97btAHpd8z1ZopaDkoNy1tHKhDhtk=";
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

  remove_vapoursynth_dep_reqtxt = 59;

  meta = with lib; {
    description = "Wrappers for scaling and descaling functions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-scale";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
