{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-masktools";
  version = "git-unstable";
  importname = "vsmasktools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "6d84c00485d6c7b07ecb50d1b81f0edd33fd2f03";
    sha256 = "xworzFZK9Zl5+llJMtMRrIwcTekgNnw78bqGWVVnSHc=";
  };

  vs_pythondeps = with vapoursynthPlugins;  [
    vs-tools
    vs-kernels
    vs-exprtools
    vs-rgtools
  ];

  vs_binarydeps = [
    
  ];

  meta = with lib; {
    description = "vs-masktools aims to provide tools and functions to manage, create, and manipulate masks in VapourSynth.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-masktools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
