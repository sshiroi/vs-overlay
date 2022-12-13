{ lib,  fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-CAS";
  version = "2";
  namespace = "cas";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "0zcqz6vgfqy4lshc0cvf8hijs2y7c4nvm5nzmb8fl8si38d96rf5";
  };

  meta = with lib; {
    description = "CAS filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CAS";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
