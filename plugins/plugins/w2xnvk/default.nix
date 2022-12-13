{ lib, stdenv, fetchFromGitHub, fetchurl, cmake, pkg-config, vulkan-headers, ncnn, p7zip, vulkan-loader, vapoursynth, glslang }:
let
  models = fetchurl {
    url = "https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan/releases/download/r0.1/models.7z";
    sha256 = "sha256-47ewtxymBgMYIaxdY7T/JatodOhSFSFYXeSjCLL5dMk=";
  };
in
stdenv.mkDerivation rec {
  name = "vapoursynth-waifu2x-ncnn-vulkan";
  version = "5";

  src = fetchFromGitHub {
    owner = "Nlzy";
    repo = name;
    rev = "r${version}";
    sha256 = "sha256-3RHbsqPlVjHtvnoLZ7eQhDipmVxqNPegiC8EMZY39Io=";
  };

  cmakeFlags = [
    "-DGLSLANGVALIDATOR_EXECUTABLE=${glslang}/bin/glslangValidator"
    "-DVAPOURSYNTH_HEADER_DIR=${vapoursynth}/include/vapoursynth"

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
  cp libvsw2xnvk.so $out/lib/vapoursynth
  mv $NIX_BUILD_TOP/mmm/* $out/lib/vapoursynth
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "w2xnvk";

  meta = with lib; {
    description = "Waifu2x filter for VapourSynth, based on waifu2x-ncnn-vulkan.";
    homepage = "https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
