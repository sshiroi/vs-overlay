{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-exprtools";
  version = "git-unstable";
  importname = "vsexprtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "8eeea60cb70dc180a8f68974df2843e6303ca61b";
    sha256 = "CyEGVBQzbIcgnLPyR2MJOi/rso8bJpEKNpYcx3ua/BU=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
  ];
  vs_binarydeps = [ ];

  meta = with lib; {
    description = "VapourSynth functions and helpers for writing RPN expressions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-exprtools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
