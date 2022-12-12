{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth, fftwSinglePrec }:

stdenv.mkDerivation rec {
  pname = "FFTSpectrum";
  version = "unstable-2022-12-12";
  #version ">1"

  src = fetchFromGitHub {
    owner = "Beatrice-Raws";
    repo = pname;
    rev = "6326b2e87ad577573fbe007d8f82d5fbe63b3c11";
    sha256 = "sha256-CJuNgfEr5jJgp84XoO71WdP1Ln7QUOH0Xq3YewCnTfI=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth fftwSinglePrec ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  NIX_CFLAGS_COMPILE = [
    #"-march=skylake"
    "-msse4.1"
  ];
  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "fftspectrum";

  meta = with lib; {
    description = "A VapourSynth filter that displays the FFT frequency spectrum of a given clip";
    homepage = "https://github.com/Beatrice-Raws/FFTSpectrum";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
