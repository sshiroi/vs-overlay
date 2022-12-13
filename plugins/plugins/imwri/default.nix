{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, imagemagick, libheif, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vs-imwri";
  version = "2";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "R${version}";
    sha256 = "sha256-1YDmpFZ3S75OjpNoSXOZOtsi1BrI+sFCrtcWdqNrMCA=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ imagemagick libheif vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "imwri";

  meta = with lib; {
    description = "Image reader and writer for VapourSynth using the ImageMagick library";
    homepage = "https://github.com/vapoursynth/vs-imwri";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
