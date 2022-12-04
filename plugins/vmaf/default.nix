{ lib, stdenv, fetchFromGitHub, meson, ninja, cmake, pkg-config, libvmaf , vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-VMAF";
  version = "10";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-p7tLNgTdaFNDfKZjaY8ha38yq+45nQYvYS00QD9ox1Y=";
  };

  nativeBuildInputs = [ meson cmake ninja pkg-config vapoursynth ];
  buildInputs = [ libvmaf ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "vmaf";

  meta = with lib; {
    description = "Video Multi-Method Assessment Fusion";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VMAF";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
