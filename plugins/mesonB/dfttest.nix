{ lib,  fetchFromGitHub, fetchpatch, mkVapoursynthMesonB, cmake, fftwFloat }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-DFTTest";
  version = "7";
  namespace = "dfttest";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "1a13lziplfn8czn0rzpdj8pki8hjs2j1450xki3j09lb2ql2fm6q";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fftwFloat ];

  patches = [
    # handle fftw3f_threads dependency
    (fetchpatch {
      url = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DFTTest/commit/89034df3fa630cbc9d73fd3ed9bcc222468f3fee.diff";
      sha256 = "0hm00wqqnb1f1kqbvyxyj37b5050dqzlb2cvp86qqiaai7fwq29y";
    })
  ];

  meta = with lib; {
    description = "A DFTTest filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DFTTest";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
