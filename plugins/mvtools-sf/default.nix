{ lib, stdenv, vapoursynthPlugins, fetchFromGitHub, meson, ninja, cmake, pkg-config, fftw, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-mvtools-sf";
  version = "unstable-2022-10-15";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "38dadba1ef853a90fab51aa886c455587173630b";
    sha256 = "sha256-dQFHu8DDW7L5RrUraEAlwNrAOgBL2tbQBAgY9jkrUMs=";
  };

  nativeBuildInputs = [ meson cmake ninja pkg-config ];
  buildInputs = [ vapoursynth fftw vapoursynthPlugins.vapoursynth-plusplus ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vs.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "mvsf";

  meta = with lib; {
    description = "Single Precision MVTools";
    homepage = "https://github.com/IFeelBloated/vapoursynth-mvtools-sf";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
