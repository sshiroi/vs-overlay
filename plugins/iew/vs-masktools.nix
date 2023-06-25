{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-masktools";
  version = "git-1.1.1";
  importname = "vsmasktools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "6f85784f516934df6672ba0b7f08087f6d989bad";
    sha256 = "sha256-5edyKzkKuNUfaBMy6/ct11xYQhbVOwye58jalShkLB4=";
  };

  vs_pythondeps = with vapoursynthPlugins;  [
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
  ];

  vs_binarydeps = [
    
  ];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "vs-masktools aims to provide tools and functions to manage, create, and manipulate masks in VapourSynth.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-masktools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
