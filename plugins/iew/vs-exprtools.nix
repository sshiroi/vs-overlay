{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-exprtools";
  version = "git-1.4.5";
  importname = "vsexprtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "b3fe144e09a101d64c3d2134ad9fbae7512655e6";
    sha256 = "sha256-MctDsdQcXxNKOwoE5bOkWmhZhsFL3DpLmWxMl2y1RPs=";
  };

  vs_pythondeps = with vapoursynthPlugins; [
    vs-tools
  ];
  vs_binarydeps = [ ];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "VapourSynth functions and helpers for writing RPN expressions.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-exprtools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
