{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA, vapoursynth }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-tivtc";
  version = "2";
  namespace = "tivtc";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-nfvvZtJwzmU9erizbSGrXCWEYqwbemiD0eLkFkfLNwM=";
  };

  meta = with lib; {
    description = "A vapoursynth filter for field matching and decimation. Avisynth port.";
    homepage = "https://github.com/dubhater/vapoursynth-tivtc";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
