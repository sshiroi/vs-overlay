{ lib, stdenv, fetchFromGitHub, pkg-config, vapoursynth }:
let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "VapourSynth-surfaceBlur";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "MoePus";
    repo = pname;
    rev = "f8fac49101d7b7dcb56f3ac8437a913fd1700219";
    sha256 = "sha256-wqUJVXbSHZsdOJmYnAN9dgV/FoeGzwxR/w4LbEblqv4=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ vapoursynth ];

  buildPhase = ''
    $CXX -o libsurfaceblur${ext} -fPIC -shared -O2 -mavx \
        $(pkg-config --cflags vapoursynth) \
        VSPlugin.cpp
  '';

  installPhase = ''
    install -D libsurfaceblur${ext} $out/lib/vapoursynth/libsurfaceblur${ext}
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "surfaceblur";

  meta = with lib; {
    description = "Repairs bright and dark line artifacts near the border of an image";
    homepage = "https://github.com/MoePus/VapourSynth-surfaceBlur";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
