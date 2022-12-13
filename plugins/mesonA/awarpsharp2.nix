{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-awarpsharp2";
  version = "4";
  namespace = "warp";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "166z0n565kk11mn63nzzzagcy0vbbm73npmvpjzzy9fn7y1g87n0";
  };

  meta = with lib; {
    description = "VapourSynth edge sharpener plugin";
    homepage = "https://github.com/dubhater/vapoursynth-awarpsharp2";
    license = licenses.isc;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
