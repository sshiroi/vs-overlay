{ lib, fetchFromGitHub, mkVapoursynthMesonB, fftwSinglePrec }:

mkVapoursynthMesonB rec {
  pname = "FFTSpectrum";
  version = "unstable-2022-12-12";
  #version ">1"
  namespace = "fftspectrum";

  src = fetchFromGitHub {
    owner = "Beatrice-Raws";
    repo = pname;
    rev = "6326b2e87ad577573fbe007d8f82d5fbe63b3c11";
    sha256 = "sha256-CJuNgfEr5jJgp84XoO71WdP1Ln7QUOH0Xq3YewCnTfI=";
  };

  buildInputs = [ fftwSinglePrec ];

  NIX_CFLAGS_COMPILE = [
    #"-march=skylake"
    "-msse4.1"
  ];

  meta = with lib; {
    description = "A VapourSynth filter that displays the FFT frequency spectrum of a given clip";
    homepage = "https://github.com/Beatrice-Raws/FFTSpectrum";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
