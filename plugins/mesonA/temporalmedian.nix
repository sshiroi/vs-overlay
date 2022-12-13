{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-temporalmedian";
  version = "1";
  namespace = "tmedian";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-UMYBA0kAGiNdcacV25O0pFgbt8bYbhS19u6edZfugYE=";
  };

  meta = with lib; {
    description = "temporal denoising filter";
    homepage = "https://github.com/dubhater/vapoursynth-temporalmedian";
    license = licenses.isc;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
