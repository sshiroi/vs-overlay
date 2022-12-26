{ lib, stdenv, fetchFromGitHub, pkg-config, vapoursynth }:

let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "vs-morpho-obsolete";
  version = "1";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-Tx6ds9oiklbC1FowRUIEogVT+7TZgbXvZKFnj1Qc6gQ=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ vapoursynth ];

  buildPhase = ''
    $CC -o libmorpho${ext} -fPIC -shared -O2 -Wall -Wextra -Wno-unused-parameter \
        $(pkg-config --cflags vapoursynth) \
        src/morpho.c src/morpho_filters.c src/morpho_selems.c
  '';

  installPhase = ''
    install -D libmorpho${ext} $out/lib/vapoursynth/libmorpho${ext}
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "morpho";

  meta = with lib; {
    description = "Morphological filters for VapourSynth";
    homepage = "https://github.com/vapoursynth/vs-morpho-obsolete";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
