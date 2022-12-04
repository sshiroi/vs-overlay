{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vs-removegrain";
  version = "unstable-2022-11-27";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "89ca38a6971e371bdce2778291393258daa5f03b";
    sha256 = "sha256-UcS8EjZGCX00Pt5pAxBTzCiveTKS5yeFT+bQgXKnJ+k=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "rgvs";

  meta = with lib; {
    description = "VapourSynth port of RemoveGrain and Repair plugins from Avisynth";
    homepage = "https://github.com/vapoursynth/vs-removegrain";
    license = with licenses; [ mit unfree wtfpl ]; # only some files have license header
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
