{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-minideen";
  version = "2";
  namespace = "minideen";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-nwKK/dojmYEG/8d3shxyynNh0BbZbMk5ilvWtFBYzms=";
  };

  NIX_CFLAGS_COMPILE = [
    "-O3"
  ];

  meta = with lib; {
    description = "Spatial denoising plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-minideen";
    license = licenses.isc;
    maintainers = with maintainers; [ aidalgol ];
    platforms = platforms.all;
  };
}