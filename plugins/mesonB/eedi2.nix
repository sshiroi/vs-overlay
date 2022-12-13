{ lib,  fetchFromGitHub, mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "vapoursynth-eedi2";
  version = "7.1";
  namespace = "eedi2";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-EEDI2";
    rev = "r${version}";
    sha256 = "10yfndb4q5zd450v5di331r3hm1mfikw370jvxydd98b0lbjpp8f";
  };

  meta = with lib; {
    description = "EEDI2 filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
