{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA, cmake, fftwFloat }:

mkVapoursynthMesonA rec {
  pname = "vcm";
  version = "unstable-2022-12-11";
  namespace = "vcm";

  src = fetchFromGitHub {
    owner = "AmusementClub";
    repo = pname;
    rev = "c770bbcfc10f5f3753388cbb680706ba6fbe218c";
    sha256 = "sha256-MsoONLCbNYB0JYwjXNDBEduRL4SZsgXtY6+8GtghCiQ=";
  };

  postPatch = ''
    substituteInPlace meson.build \
        --replace "#install:" "install:"
  '';

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fftwFloat ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/AmusementClub/vcm";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
