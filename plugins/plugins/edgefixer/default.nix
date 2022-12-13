{ lib, stdenv, fetchFromGitHub, pkg-config, vapoursynth }:
let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "EdgeFixer";
  version = "unstable-2022-11-223";

  src = fetchFromGitHub {
    owner = "sekrit-twc";
    repo = pname;
    rev = "4e44dff69bb8e7d20757c7f68755483f34a7aa0f";
    sha256 = "sha256-/c7QyZgBfJp5xiCQJUs9nSeDku5wQdT9kwUgizxhX30=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ vapoursynth ];

  patches = [
    ./fix.patch
  ];

  buildPhase = ''
    $CC -o libedgefixer${ext} -fPIC -shared -O2 \
        $(pkg-config --cflags vapoursynth) \
        EdgeFixer/edgefixer.c EdgeFixer/vsplugin.c
  '';

  installPhase = ''
    install -D libedgefixer${ext} $out/lib/vapoursynth/libedgefixer${ext}
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "edgefixer";

  meta = with lib; {
    description = "Repairs bright and dark line artifacts near the border of an image";
    homepage = "https://github.com/sekrit-twc/EdgeFixer";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
