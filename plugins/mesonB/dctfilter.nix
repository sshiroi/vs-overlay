{ lib, fetchFromGitHub, mkVapoursynthMesonB, fftwFloat }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-DCTFilter";
  version = "2.1";
  namespace = "dctf";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "032l2dh28jznplh8ww8hzr0fmm6hx34f0k29gqyyjksmn3ympr00";
  };

  buildInputs = [ fftwFloat ];

  meta = with lib; {
    description = "Renewed DCTFilter filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DCTFilter";
    license = licenses.mit;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
