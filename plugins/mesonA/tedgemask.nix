{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-tedgemask";
  version = "1";
  namespace = "tedgemask";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-7ODhuW6UAG6TltuNNOWUWE9JbB6rXYcoGp/j7okXS5I=";
  };

  meta = with lib; {
    description = "edge detection filter";
    homepage = "https://github.com/dubhater/vapoursynth-tedgemask";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}