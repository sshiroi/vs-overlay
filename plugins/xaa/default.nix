{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, python, vapoursynth }:
let
  propagatedBinaryPlugins = with vapoursynthPlugins; [
    eedi2
    eedi3m
    znedi3
    nnedi3cl
    removegrain
    sangnom
    tcanny
    tedgemask
  ];
in
buildPythonPackage rec {
  pname = "vapoursynth-xaa";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "2d72de4af3cc990f11c4d0b753fd04fc1b17a242";
    sha256 = "sha256-1bvd0lBcca172bi+OCyiIhio+diz43WtayjtupVWhx4=";
  };

  propagatedBuildInputs = with vapoursynthPlugins; [  ] ++ propagatedBinaryPlugins;

  format = "other";

  installPhase = ''
    install -D xaa.py $out/${python.sitePackages}/xaa.py
  '';

  checkInputs = [ (vapoursynth.withPlugins ( propagatedBinaryPlugins )) ];
  checkPhase = ''
    PYTHONPATH=$out/${python.sitePackages}:$PYTHONPATH
  '';
  pythonImportsCheck = [ "xaa" ];

  meta = with lib; {
    description = "many-in-one antialiasing function for VapourSynth.";
    homepage = "https://github.com/dubhater/vapoursynth-xaa/";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
