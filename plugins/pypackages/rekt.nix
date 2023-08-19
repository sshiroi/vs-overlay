{ lib, mkVapoursynthPythonSetuptools, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSetuptools rec {
  pname = "rekt";
  version = "unstable-2022-12-04";
  importname = "rekt";

  src = fetchFromGitHub {
    owner = "OpusGang";
    repo = pname;
    rev = "db889a53ecbdf7d7c592d8738d95b4901a80f851";
    sha256 = "sha256-C9rawTInpeJtIREVDyInQmgm8OZfAq1lA/SyAu/M5bY=";
  };

  vs_pythondeps = [];
  vs_binarydeps = [];

  propagatedBuildInputs = with vapoursynthPlugins; [
    vsutil
  ];

  meta = with lib; {
    description = "VapourSynth wrapper for Cropping and Stacking clips";
    homepage = "https://gitlab.com/Ututu/rekt";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
