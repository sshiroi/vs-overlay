{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-exprtools";
  version = "git-1.4.0";
  importname = "vsexprtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "23b824a50db187b500b0dcb37e69afa2ba64198a";
    sha256 = "sha256-t/Iz6JlrL3onnp2NUnXXeN8uhW3RFFrnMtoTz5HK37E=";
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
