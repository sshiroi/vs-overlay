{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, fftwFloat, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-FFT3DFilter";
  version = "unstable-2022-12-11";

  src = fetchFromGitHub {
    owner = "myrsloik";
    repo = pname;
    rev = "50194b45430abbb5bcbd8e8d016d81c83be8a599";
    sha256 = "sha256-wdQHGEggMISCNr/tZRIPmAu11RM2hMc6y5oXriGcn08=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ fftwFloat vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "fft3dfilter";

  meta = with lib; {
    description = "A VapourSynth port of FFT3DFilter";
    homepage = "https://github.com/myrsloik/VapourSynth-FFT3DFilter";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
