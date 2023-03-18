{ lib, mkVapoursynthMesonB, fetchFromGitHub, cmake, vulkan-loader, vulkan-headers, ncnn }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-RIFE-ncnn-Vulkan";
  version = "9";
  namespace = "rife";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "${pname}";
    rev = "r${version}";
    sha256 = "sha256-RNvLVyaGOAdcASur8AGl1t0tgRdxxBlZl/wAI9XNENM=";
  };

  mesonFlags = [
    "-Duse_system_ncnn=true"
  ];


  preConfigure = ''
    substituteInPlace meson.build --replace "dependency('ncnn', method: 'cmake')" "[dependency('ncnn', method: 'cmake').partial_dependency(compile_args: false,includes:true,link_args:true,links:true,sources:true), declare_dependency(compile_args: '-I${ncnn}/include/ncnn' )]"
  '';
  #-I${vulkan-headers}/include

  modeb_replace = "vapoursynth_dep.get_variable(pkgconfig: 'libdir')";
  hovr_disable_lto = true;

  nativeBuildInputs = [ cmake vulkan-headers ];
  buildInputs = [ vulkan-loader ncnn ];

  meta = with lib; {
    description = "Real-Time Intermediate Flow Estimation for Video Frame Interpolation, based on rife-ncnn-vulkan.";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-RIFE-ncnn-Vulkan";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}