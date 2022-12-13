{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-sangnom";
  version = "42";
  namespace = "sangnom";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "r${version}";
    sha256 = "0g9gr4lj5krwlkxb6fc1b408zj5gnl8v36hr66r27h9ndg12flfs";
  };

  meta = with lib; {
    description = "VapourSynth Single Field Deinterlacer";
    homepage = "https://github.com/dubhater/vapoursynth-sangnom";
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
