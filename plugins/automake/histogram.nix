{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-histogram";
  version = "unstable-2022-11-27";
  namespace = "hist";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "c4861d63d496fa0eb873a6f949937be8c9c1dc13";
    sha256 = "sha256-0oSIHnzFfnuKMZA6jPSeyV2ekRlbJOnTyxzi2B9DF0k=";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  meta = with lib; {
    description = "Histogram plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-histogram";
    license = licenses.gpl2Plus; # https://github.com/dubhater/vapoursynth-histogram/issues/2
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
