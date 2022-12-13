{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-smoothuv";
  version = "3";
  namespace = "smoothuv";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 ="sha256-XwUBuoDkpD3NSqxtjACD1THsVHFLNAiFVnGYDeCbqoo=";
  };

  NIX_CFLAGS_COMPILE = [
    "-fpeel-loops"
  ];

  meta = with lib; {
    description = "SmoothUV is a spatial derainbow filter.";
    homepage = "https://github.com/dubhater/vapoursynth-smoothuv";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
