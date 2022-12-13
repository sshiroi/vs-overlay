{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-dedot";
  version = "1";
  namespace = "dedot";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 ="sha256-MTd4fCTyiVYElEevfDU4EDLmW5qCEVEQK3wr+vfkEv8=";
  };

  meta = with lib; {
    description = "Dedot is a temporal cross color";
    homepage = "https://github.com/dubhater/vapoursynth-dedot";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
