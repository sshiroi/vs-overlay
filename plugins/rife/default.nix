{ lib, stdenv, fetchFromGitHub, meson, pkg-config, cmake, ninja, vulkan-headers, vulkan-loader, vapoursynth, ncnn }:
stdenv.mkDerivation rec {
  name = "VapourSynth-RIFE-ncnn-Vulkan";
  version = "9";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "${name}";
    rev = "r${version}";
    sha256 = "sha256-RNvLVyaGOAdcASur8AGl1t0tgRdxxBlZl/wAI9XNENM=";
  };

  mesonFlags = [
    "-Duse_system_ncnn=true"
  ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"
  '';

  nativeBuildInputs = [ meson cmake pkg-config ninja vulkan-headers ];
  buildInputs = [ vapoursynth vulkan-loader ncnn ];

  meta = with lib; {
    description = "Real-Time Intermediate Flow Estimation for Video Frame Interpolation, based on rife-ncnn-vulkan.";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
