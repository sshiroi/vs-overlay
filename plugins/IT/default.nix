{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, which, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-IT";
  version = "unstable-2022-11-24";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "6fc9be84571cd0cc1a48ad12be8bb19985cd9cfb";
    sha256 = "sha256-bzJyy0bssw4FV1TTPPDikxwDZ9ycTx5o6JuN3KP3Jws=";
  };

  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [ vapoursynth ];

  configurePhase = ''
  ./configure --cxx=$CXX --install=$out/lib/vapoursynth
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "it";

  meta = with lib; {
    description = "Inverse Telecine";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-IT";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
