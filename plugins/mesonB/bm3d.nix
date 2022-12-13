{ lib, fetchFromGitHub, mkVapoursynthMesonB, fftwSinglePrec }:

mkVapoursynthMesonB rec {
  pname = "vapoursynth-bm3d";
  version = "9";
  namespace = "bm3d";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "VapourSynth-BM3D";
    rev = "r${version}";
    sha256 = "sha256-i7Kk7uFt2Wo/EWpVkGyuYgGZxBuQgOT3JM+WCFPHVrc=";
  };

  buildInputs = [ fftwSinglePrec ];

  meta = with lib; {
    description = "BM3D denoising filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D";
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
