{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-fillborders";
  #version = ">2";
  version = "unstable-2022-12-12";
  namespace = "fb";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "78fe68044fe3414ce8061bf811a235e29c8f7d9d";
    sha256 = "sha256-mAeFVG9Mi7AIubRdakhJJIdRtXmT0b5YXpEWp4me6uI=";
  };

  meta = with lib; {
    description = "VapourSynth plugin to fill the borders of a clip";
    homepage = "https://github.com/dubhater/vapoursynth-fillborders";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
