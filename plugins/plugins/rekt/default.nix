{ lib, buildPythonPackage, fetchFromGitHub, vapoursynthPlugins, vapoursynth }:

buildPythonPackage rec {
  pname = "rekt";
  version = "unstable-2022-12-04";

  src = fetchFromGitHub {
    owner = "OpusGang";
    repo = pname;
    rev = "db889a53ecbdf7d7c592d8738d95b4901a80f851";
    sha256 = "sha256-C9rawTInpeJtIREVDyInQmgm8OZfAq1lA/SyAu/M5bY=";
  };

  # This does not depend on vapoursynth (since this is used from within
  # vapoursynth).
  postPatch = ''
    substituteInPlace setup.py \
        --replace "'VapourSynth>=57'," ""
  '';

  propagatedBuildInputs = with vapoursynthPlugins; [
    vsutil
  ];

  checkInputs = [ vapoursynth ];
  checkPhase = ''
    runHook preCheck
    # This overrides the default setuptools checkPhase that detects tests (that
    # don’t work) even though this package doesn’t have tests.
    runHook postCheck
  '';

  pythonImportsCheck = [ "rekt" ];

  meta = with lib; {
    description = "VapourSynth wrapper for Cropping and Stacking clips";
    homepage = "https://gitlab.com/Ututu/rekt";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
