{ lib, stdenv, fetchFromGitHub, pkg-config, which, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-VagueDenoiser";
  version = "unstable-2022-12-12";

  #github is archived
  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "f925f1a8ad763289df090410838fff5cb0453b6e";
    sha256 = "sha256-Of/cKbylhAydwt59o4qIM7dgwAESRqsahD16QeXm1Us=";
  };

  configurePhase = ''
  ./configure --cxx=$CXX --install=$out/lib/vapoursynth
  '';

  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "vd";

  meta = with lib; {
    description = "wavelet based denoiser";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VagueDenoiser";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
