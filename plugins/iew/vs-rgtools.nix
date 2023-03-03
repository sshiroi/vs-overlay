{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, numpy, pyfftw }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-rgtools";
  version = "git-1.4.0";
  importname = "vsrgtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "574ed992db8b0a89630cfc3172b5f7f532f0c4f0";
    sha256 = "sha256-Ufdol/pFRqXLaf6xRososfHizmqKQovsS30p9RSek24=";
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
  remove_vapoursynth_dep_reqtxt = 60;

  meta = with lib; {
    description = "Wrapper for RGVS, RGSF, and various other functions";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-rgtools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
