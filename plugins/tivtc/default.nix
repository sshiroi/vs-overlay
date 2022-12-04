{ lib, stdenv, fetchFromGitHub, meson, pkg-config, ninja, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-tivtc";
  version = "2";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-nfvvZtJwzmU9erizbSGrXCWEYqwbemiD0eLkFkfLNwM=";
  };

  nativeBuildInputs = [ meson pkg-config ninja ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  meta = with lib; {
    description = "A vapoursynth filter for field matching and decimation. Avisynth port.";
    homepage = "https://github.com/dubhater/vapoursynth-tivtc";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
