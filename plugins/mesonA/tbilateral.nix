{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-tbilateral";
  version = "4";
  namespace = "tbilateral";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-jGfkDasB78F+tCNGwp/04zYs9N6Jcipmp1YTzKb6vug=";
  };

  meta = with lib; {
    description = "spatial smoothing filter";
    homepage = "https://github.com/dubhater/vapoursynth-tbilateral";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
