{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "vapoursynth-cmedian";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "4re";
    repo = pname;
    rev = "c19dd5c1df804a4ee71fcce29de251d978c7dc9c";
    sha256 = "sha256-w3skSlCUZ6r2WdV6KEWkKfk18ySScL56ncCyH25wGog=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "cmedian";

  meta = with lib; {
    description = "constant time median filter algorithm";
    homepage = "https://github.com/4re/vapoursynth-cmedian";
    license = licenses.lgpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
