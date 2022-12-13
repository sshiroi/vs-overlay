{ lib, fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-Retinex";
  version = "unstable-2022-12-04";
  namespace = "retinex";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "6bfbdd429159c85075dc4b08e0ac4e706470916b";
    sha256 = "sha256-4LnVyW3m91PHE5L1qYT+O23bJpqxggpZ+kp0NLQzvWw=";
  };

  meta = with lib; {
    description = "Retinex algorithm for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Retinex";
    license = licenses.gpl3;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
