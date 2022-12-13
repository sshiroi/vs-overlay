{ lib,  fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-tonemap";
  version = "2";
  namespace = "tonemap";

  src = fetchFromGitHub {
    owner = "ifb";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-GtXMxxiUljHchTPG7oj6Frwc19IG3BDyFO9TjII4AGU=";
  };

  meta = with lib; {
    description = "Histogram plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-tonemap";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
