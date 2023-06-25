{ lib, fetchFromGitHub, ffmpeg_4, libass, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "subtext";
  version = "3";
  namespace = "sub";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-Tux8WFbUn4Bt1EL9r+f+Y/av9w9Y23gc79m1JcZWj50=";
  };

  buildInputs = [ ffmpeg_4 libass ];

  meta = with lib; {
    description = "Subtitle plugin for VapourSynth based on libass";
    homepage = "https://github.com/vapoursynth/subtext";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
