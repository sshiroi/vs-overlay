{ lib, stdenv, fetchFromGitHub, pkg-config, vapoursynth }:
let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "VapourSynth-AreaResize";
  version = "2";

  src = fetchFromGitHub {
    owner = "Kiyamou";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-Xdh52q19+AeReMXGiZkJpXo7aGGUzdT7WLJDV8ZrG4I=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ vapoursynth ];

  buildPhase = ''
    $CXX -o libarearesize${ext} -fPIC -shared -O2 \
        $(pkg-config --cflags vapoursynth) \
        AreaResize/AreaResize.cpp
  '';

  installPhase = ''
    install -D libarearesize${ext} $out/lib/vapoursynth/libarearesize${ext}
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "area";

  meta = with lib; {
    description = "area average downscale resizer plugin";
    homepage = "https://github.com/MoePus/VapourSynth-surfaceBlur";
    license = licenses.unfree; # dunno what licenese
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
