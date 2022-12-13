{ lib, fetchFromGitHub, mkVapoursynthAutomake }:

mkVapoursynthAutomake rec {
  pname = "vapoursynth-degrainmedian";
  version = "1";
  namespace = "dgm";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-C6IJaO86LuFaKSWG6O+jCYQE1owbF2OC3L+sG7KVeM4=";
  };

  meta = with lib; {
    description = "DegrainMedian is a spatio-temporal limited median denoiser";
    homepage = "https://github.com/dubhater/vapoursynth-degrainmedian";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
