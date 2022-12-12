{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "vapoursynth-smoothuv";
  version = "3";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 ="sha256-XwUBuoDkpD3NSqxtjACD1THsVHFLNAiFVnGYDeCbqoo=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  NIX_CFLAGS_COMPILE = [
    "-fpeel-loops"
  ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "smoothuv";

  meta = with lib; {
    description = "SmoothUV is a spatial derainbow filter.";
    homepage = "https://github.com/dubhater/vapoursynth-smoothuv";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
