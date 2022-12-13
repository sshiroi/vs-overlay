{ fetchFromGitHub, lib, mkVapoursynthMesonA }:

mkVapoursynthMesonA rec {
  pname = "vapoursynth-median";
  version = "4";
  namespace = "median";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "16x0ig17kg5xkh9qwv9fx4nmpd6cs53nr4jj1bsh0dm76rlwsynv";
  };

  meta = with lib; {
    description = "VapourSynth plugin to generate a pixel-by-pixel median of several clips";
    homepage = "https://github.com/dubhater/vapoursynth-median/";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
