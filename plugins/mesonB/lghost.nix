{ lib, fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-LGhost";
  version = "1";
  namespace = "lghost";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-ckcBtHNoD/jukVgXgbFdg6DCkT98KOK8eP1U+6+cb+k=";
  };

  meta = with lib; {
    description = "Ghost reduction filter";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-LGhost";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
