{ lib, mkVapoursynthPythonSetuptools, fetchFromGitHub, vapoursynthPlugins }:

mkVapoursynthPythonSetuptools rec {
  pname = "rekt";
  version = "unstable-2022-12-04";
  importname = "rekt";

  src = fetchFromGitHub {
    owner = "OpusGang";
    repo = pname;
    rev = "c9fc7553a1dbb1a3c50a6fa8774855d8719870e7";
    sha256 = "sha256-XxfB0NeifCAWbSm4HIwTjeV5Gq++qtKXCeFaoqMVwtI=";
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
