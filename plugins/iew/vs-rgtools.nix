{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, numpy, pyfftw }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-rgtools";
  version = "git-unstable";
  importname = "vsrgtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "81da5f79c58d3802ba80ac49bb517f3529bba111";
    sha256 = "z3T1w6xolGEri7fnfk8A8RR+UlX5OQz/sHrX7L54UhU=";
  };

  propagatedBuildInputs = [ numpy pyfftw ];

  vs_pythondeps = with vapoursynthPlugins; [
    vs-exprtools
    vs-tools
    vs-pyplugin
  ];

  vs_binarydeps = with vapoursynthPlugins; [
    removegrain
    rgsf
    akarin
    ctmf
  ];

  meta = with lib; {
    description = "Wrapper for RGVS, RGSF, and various other functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-rgtools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
