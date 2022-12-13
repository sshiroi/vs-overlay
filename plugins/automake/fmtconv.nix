{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "fmtconv";
  version = "30";
  namespace = "fmtc";

  src = fetchFromGitHub {
    owner = "EleonoreMizo";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-G4foN3toSSq4objbdiFpc+0ZxjF7VNQhyyixnJj6Gkw=";
  };

  preAutoreconf = "cd build/unix";

  meta = with lib; {
    description = "Format conversion tools for VapourSynth";
    homepage = "https://github.com/EleonoreMizo/fmtconv";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
