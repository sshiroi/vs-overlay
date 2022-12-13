{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:

buildPythonPackage rec {
  pname = "mvsfunc";
  version = "unstable-2022-11-27";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "f3167b8a2789ea1527e5249b02906420c95f2c7b";
    sha256 = "sha256-ftfL0/SsCxfSS/IDvg45XTWbJAhlSwCu5Po/pEVqQJc=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [
    bm3d
    fmtconv
  ];

  postPatch = ''
    substituteInPlace requirements.txt \
        --replace "VapourSynth>=45" "" \
  '';

  checkInputs = [ (vapoursynth.withPlugins propagatedBuildInputs) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "mvsfunc" ];

  meta = with lib; {
    description = "mawen1250’s VapourSynth functions";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/mvsfunc";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
