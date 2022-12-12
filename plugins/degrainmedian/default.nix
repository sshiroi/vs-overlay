{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-degrainmedian";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-C6IJaO86LuFaKSWG6O+jCYQE1owbF2OC3L+sG7KVeM4=";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "dgm";

  meta = with lib; {
    description = "DegrainMedian is a spatio-temporal limited median denoiser";
    homepage = "https://github.com/dubhater/vapoursynth-degrainmedian";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
