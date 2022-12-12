{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-DeblockPP7";
  version = "4.1";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-3dGg7vTidCNpjTAocM85S0wg74nkogR1yjepbznQpJo=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "pp7";

  meta = with lib; {
    description = "Variant of the spp filter in MPlayer, similar to spp=6 with 7 point DCT where only the center sample is used after IDCT.";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DeblockPP7";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
