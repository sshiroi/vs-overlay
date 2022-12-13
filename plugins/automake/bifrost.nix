{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-bifrost";
  version = "2.2";
  namespace = "bifrost";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "0ivmxgqfp9d6axvznkjcckv6ajvs0advx6iisvry52pfc8lprbp8";
  };

  meta = with lib; {
    description = "Bifrost (temporal derainbowing) plugin for Vapoursynth";
    homepage = "https://github.com/dubhater/vapoursynth-bifrost";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
