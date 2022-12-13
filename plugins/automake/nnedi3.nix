{ lib, fetchFromGitHub, mkVapoursynthAutomake, yasm }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-nnedi3";
  version = "12";
  namespace = "nnedi3";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "1valcf8ns4wrfq6q5js029a93i58vr37mqw5na6922avg04wzpwd";
  };

  buildInputs = [ yasm ];

  meta = with lib; {
    description = "nnedi3 filter for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-nnedi3";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
