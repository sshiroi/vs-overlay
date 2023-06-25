{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, numpy, pyfftw }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-rgtools";
  version = "git-1.5.0";
  importname = "vsrgtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "128cba8f4115b99f216a72c37410f5b1446cecaf";
    sha256 = "sha256-O2hisvXXea3VpfMfSr3CmS93ec5pGLsxiwoPa6hlxCc=";
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
