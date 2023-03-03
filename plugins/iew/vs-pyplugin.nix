{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, python3, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-pyplugin";
  version = "git-1.3.0";
  importname = "vspyplugin";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "1f5f57df5209eaa57d713eec4be77c31b5615868";
    sha256 = "sha256-4g/IW0OcAhYpEF5STMYPP+OIbxpIwgX5Vyuqz1zZXlY=";
  };

  vs_pythondeps = with vapoursynthPlugins;  [ vs-tools ];
  vs_binarydeps = [];

  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "Package for simplifying writing VapourSynth plugins in python.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-pyplugin";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
