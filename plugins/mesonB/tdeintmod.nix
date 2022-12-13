{ lib, fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-TDeintMod";
  version = "10.1";
  namespace = "tdm";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-bVo9yIu25xWSY4my1Wf+A80/yn3MmcPkncHxzq02G+E=";
  };

  meta = with lib; {
    description = "A vapoursynth filter combining of TDeint and TMM";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TDeintMod";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
