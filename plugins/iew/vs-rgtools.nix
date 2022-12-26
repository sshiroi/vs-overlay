{ lib, vapoursynthPlugins, mkVapoursynthPythonSetuptools, fetchFromGitHub, numpy, pyfftw }:

mkVapoursynthPythonSetuptools rec {
  pname = "vs-rgtools";
  #version = "1.2.0";
  version = "1.3.2";
  importname = "vsrgtools";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "7bc9eaf5f1699c69db27ad11757a5be3b60c053a";
    sha256 = "sha256-NENE7+Eh9jU9y3Ql2S6/YE+Y956xC7px6loU5x3wiV4=";
  #  rev = "v${version}";
  #  sha256 = "sha256-tKOEKCg2/h4lgBVgb062IAapzzI40UwHOAJvTjxW2CM=";
  };

  propagatedBuildInputs = [ numpy pyfftw ];

  vs_pythondeps = with vapoursynthPlugins; [
    vs-exprtools
    vs-tools
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
