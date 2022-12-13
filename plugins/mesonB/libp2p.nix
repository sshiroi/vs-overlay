{ lib, fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "vapoursynth-libp2p";
  version = "unstable-2022-09-07";
  namespace = "libp2p";

  src = fetchFromGitHub {
    owner = "DJATOM";
    repo = "LibP2P-Vapoursynth";
    rev = "770cc3157b41b7b336b2f2e85be01830dcb80d2c";
    sha256 = "sha256-Xokf5m7UIrW1C03C4X/6D37NbDwVGxQjPk2DRz4MQic=";
  };

  meta = with lib; {
    description = "VapourSynth plugin for packing/unpacking of RGB clips";
    homepage = "https://github.com/DJATOM/LibP2P-Vapoursynth";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
