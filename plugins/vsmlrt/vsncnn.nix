{ lib, clangStdenv, stdenv, fetchFromGitHub, pkg-config, glslang, git,ninja, python_call, callPackage, cmake, ncnn, vapoursynth, vulkan-headers,vulkan-loader, which, protobuf,onnxruntime, python310Packages, shaderc }:

stdenv.mkDerivation rec {
  pname = "vsncnn";
  version = "2";

  src = fetchFromGitHub {
    owner = "AmusementClub";
    repo = "vs-mlrt";
    rev = "b20fc6e726aaa89ba147163d946cfa1579f1fcf2";
    sha256 = "6invEe0aZAWoYqB6BCJCCwk1yJuId4ZaJ+QOlD65u8w=";
  };

  patches = [
    ./vsnccn.patch
  ];

  nativeBuildInputs = [ cmake ninja git pkg-config shaderc ];
  buildInputs = [
    vapoursynth
    (ncnn.overrideAttrs (old: rec {
        cmakeFlags = [
            "-DNCNN_DISABLE_EXCEPTION=OFF"
            "-DNCNN_DISABLE_RTTI=OFF"
        ] ++ old.cmakeFlags;
    }))
    protobuf
    glslang
    #kind of buildy weirdly dunno why the nixos does not ship library
    (python_call ./onnx.nix {})
    vulkan-headers vulkan-loader
  ];

  preConfigure = ''
  cd vsncnn
  '';

  postInstall = ''
  find $out
  mkdir $out/lib/vapoursynth
  mv $out/lib/*.so $out/lib/vapoursynth/
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "ncnn";

  meta = with lib; {
    description = "This project provides VapourSynth ML filter runtimes for a variety of platforms";
    homepage = "https://github.com/AmusementClub/vs-mlrt";
    license = with licenses; [ ];
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
