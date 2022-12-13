{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-exprtools";
  version = "unstable-2022-11-26";
  importname = "vsexprtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "45301e4001d968652e01167513b9f6cac8bfb617";
    sha256 = "sha256-p2BEZRuTeHQU9RcGNk+KocjH+67XbmfalRM1BWJSeJI=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
  ];
  vs_binarydeps = [ ];

  remove_vapoursynth_dep_reqtxt = 59;

  meta = with lib; {
    description = "VapourSynth functions and helpers for writing RPN expressions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-exprtools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
