{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-masktools";
  version = "git-0.9.0";
  importname = "vsmasktools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "6c3d2bce90738ead49a8f9f086b0fa842361f7e4";
    sha256 = "sha256-bgOlZCjGMKevqjUNxTPWO699Hi16XaE4GAh6FRKq6Kg=";
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
