{ lib, stdenv, fetchFromGitHub, pkg-config, autoreconfHook, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-tonemap";
  version = "2";

  src = fetchFromGitHub {
    owner = "ifb";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-GtXMxxiUljHchTPG7oj6Frwc19IG3BDyFO9TjII4AGU=";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "tonemap";

  meta = with lib; {
    description = "Histogram plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-tonemap";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
