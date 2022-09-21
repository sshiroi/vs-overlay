{ lib, stdenv, fetchFromGitHub, fetchurl, cmake, pkg-config, vulkan-headers, ncnn, p7zip, vulkan-loader, vapoursynth, glslang }:
let
  models = fetchurl {
    url = "https://github.com/Kiyamou/VapourSynth-RealSR-ncnn-Vulkan/releases/download/r1/models.7z";
    sha256 = "sha256-+cK7w13/FZLuT482Nd0OAyqi5XW7bCE9S6XEDiBJue8=";
  };
in
stdenv.mkDerivation rec {
  name = "VapourSynth-RealSR-ncnn-Vulkan";
  version = "3";
  src = fetchFromGitHub {
    owner = "Kiyamou";
    repo = name;
    rev = "r${version}";
    sha256 = "sha256-ISRGkl8wBolZHsCCkMcofCD4cUdGupewRZtmf0CNo9E=";
  };

  cmakeFlags = [
    "-DGLSLANGVALIDATOR_EXECUTABLE=${glslang}/bin/glslangValidator"
    "-DVAPOURSYNTH_INCLUDE_DIR=${vapoursynth}/include/vapoursynth"

    "-DNCNN_INCLUDE_DIRS=${ncnn}/include/ncnn"
    "-DNCNN_LIBRARIES=ncnn"
  ];
  patches = [
    ./disable_own_ncnn.patch
  ];

  postUnpack = ''
  mkdir mmm
  cd mmm
  ${p7zip}/bin/7z x ${models}
  cd ..
  '';

  nativeBuildInputs = [ cmake pkg-config glslang ];
  buildInputs = [ vapoursynth vulkan-headers vulkan-loader ncnn ];

  installPhase = ''
  mkdir -p $out/lib/vapoursynth
  cp librealsrnv.so $out/lib/vapoursynth
  mkdir -p $out/lib/vapoursynth/models
  mv $NIX_BUILD_TOP/mmm/* $out/lib/vapoursynth/models
  '';

  meta = with lib; {
    description = "RealSR super resolution for VapourSynth";
    homepage = "https://github.com/Kiyamou/VapourSynth-RealSR-ncnn-Vulkan";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
