{ lib, fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-Deblock";
  version = "6.1";
  namespace = "deblock";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "0s2aqfak8mxylkhfl350mm8abspp7sgfacnigf7qksvhdx232k2c";
  };

  meta = with lib; {
    description = "A Deblock filter plugin for VapourSynth.";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Deblock";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
