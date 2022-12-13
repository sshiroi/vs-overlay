{ lib, stdenv, fetchFromGitHub, pkg-config,  vapoursynth }:
stdenv.mkDerivation rec {
  pname = "VapourSynth-PlaneStatsMod";
  version = "3";

  src = fetchFromGitHub {
    owner = "dnjulek";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-KHd0nWs/RJCoa8IAJDUYWenNMuFQf+sSSlY9Ok09sDk=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ vapoursynth ];

  buildPhase = ''
  $CXX -shared -fPIC -o libpsm.so -O2 src/PlaneAverage.cpp src/PlaneMinMax.cpp src/shared.cpp $(pkg-config --cflags vapoursynth)
  '';

  installPhase = ''
  mkdir -p $out/lib/vapoursynth
  install -D libpsm.so $out/lib/vapoursynth/libpsm.so
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "psm";

  meta = with lib; {
    description = "PlaneMinMax and PlaneAverage";
    homepage = "https://github.com/dnjulek/VapourSynth-PlaneStatsMod";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
