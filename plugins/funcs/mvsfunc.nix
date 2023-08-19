{ lib, mkVapoursynthPythonSetuptools, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:

mkVapoursynthPythonSetuptools rec {
  pname = "mvsfunc";
  version = "unstable-2022-11-27";
  importname = "mvsfunc";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "f3167b8a2789ea1527e5249b02906420c95f2c7b";
    sha256 = "sha256-ftfL0/SsCxfSS/IDvg45XTWbJAhlSwCu5Po/pEVqQJc=";
  };

  vs_binarydeps = with vapoursynthPlugins; [
    bm3d
    fmtconv
  ];
  vs_pythondeps = [ ];


  meta = with lib; {
    description = "mawen1250’s VapourSynth functions";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/mvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
