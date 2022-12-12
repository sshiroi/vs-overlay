{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth, cmake, fftwFloat }:
stdenv.mkDerivation rec {
  pname = "vcm";
  version = "unstable-2022-12-11";

  src = fetchFromGitHub {
    owner = "AmusementClub";
    repo = pname;
    rev = "c770bbcfc10f5f3753388cbb680706ba6fbe218c";
    sha256 = "sha256-MsoONLCbNYB0JYwjXNDBEduRL4SZsgXtY6+8GtghCiQ=";
  };

  #just whyyyyyyyy?
  patches = [
    ./install_true.patch
  ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  nativeBuildInputs = [ meson ninja pkg-config cmake ];
  buildInputs = [ vapoursynth fftwFloat ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "vcm";

  meta = with lib; {
    description = "";
    homepage = "https://github.com/AmusementClub/vcm";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
