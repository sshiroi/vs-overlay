{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "vapoursynth-frfun7";
  version = "2";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 ="sha256-trLjr9w+8ZgFYKlXE1K5NcUNN+DJLFIVncC+727jXtU=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "frfun7";

  meta = with lib; {
    description = "Frfun7 is a spatial fractal denoising plugin.";
    homepage = "https://github.com/dubhater/vapoursynth-frfun7";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
