{ lib, fetchFromGitHub, mkVapoursynthAutomake, ffmpeg }:

mkVapoursynthAutomake rec {
  pname = "d2vsource";
  version = "1.2";
  namespace = "d2v";

  #master has v4 api
  src = fetchFromGitHub {
    owner = "dwbuiten";
    repo = pname;
    rev = "v${version}";
    sha256 = "1ax20qs1hba70r07pdw3gs4gylwb2ca4iz9ycmd9i5rvxaxy4hmp";
  };

  buildInputs = [ ffmpeg ];

  meta = with lib; {
    description = "D2V parser and decoder for VapourSynth";
    homepage = "https://github.com/dwbuiten/d2vsource";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
