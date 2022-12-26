{ lib, stdenv, fetchFromGitHub, pkg-config, which, vapoursynth }:
let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in
stdenv.mkDerivation rec {
  pname = "RGSF";
  version = "5";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-/w4z8cv4cl+6e8n+fA9axIRVuDo6gFahxM4Rghkpbv0=";
  };

  postPatch = ''
  # headers are provided by nixpkgs’ vapoursynth
  rm VapourSynth.h
  rm VSHelper.h
  '';

  buildPhase = ''
  $CXX -shared -fPIC -o librgsf${ext} -O2 RGVS.cpp Clense.cpp RemoveGrain.cpp Repair.cpp VerticalCleaner.cpp $(pkg-config --cflags vapoursynth)
  '';

  installPhase = ''
  install -D librgsf${ext} $out/lib/vapoursynth/librgsf${ext}
  '';

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "rgsf";

  meta = with lib; {
    description = "RGVS Single Precision";
    homepage = "https://github.com/IFeelBloated/RGSF";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
