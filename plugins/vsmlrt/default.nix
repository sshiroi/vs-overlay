{ lib, mkVapoursynthPythonSinglefileFunc, fetchurl, p7zip, fetchFromGitHub, fetchpatch,vapoursynthPlugins }:
let
  models_w2x = fetchurl {
    url = "https://github.com/AmusementClub/vs-mlrt/releases/download/model-20211209/waifu2x_v3.7z";
    sha256 = "18mawblw97a8mhirysf3dxa9imqazqg9kran5y0zgl1mwm5s44rp";
  };
in
mkVapoursynthPythonSinglefileFunc rec {
  pname = "vs-mlrt";
  version = "unstable";
  importname = "vsmlrt";

  src = fetchFromGitHub {
    owner = "AmusementClub";
    repo = "vs-mlrt";
    rev = "b20fc6e726aaa89ba147163d946cfa1579f1fcf2";
    sha256 = "6invEe0aZAWoYqB6BCJCCwk1yJuId4ZaJ+QOlD65u8w=";
  };

  postPatch = ''
  substituteInPlace scripts/${importname}.py --replace "= get_plugins_path()" "= \"$out/lib/vapoursynth/\""
  '';

  preInstall = ''
  cp scripts/${importname}.py ${importname}.py
  '';

  postInstall = ''
  mkdir -p $out/lib/vapoursynth/models
  mv $NIX_BUILD_TOP/w2x_models/* $out/lib/vapoursynth/models
  '';

  postUnpack = ''
  mkdir w2x_models && cd w2x_models && ${p7zip}/bin/7z x ${models_w2x} && cd ..
  '';

  vs_pythondeps = [  ];
  vs_binarydeps = [ vapoursynthPlugins.vsmlrt_vsncnn ];

  meta = with lib; {
    description = "This project provides VapourSynth ML filter runtimes for a variety of platforms";
    homepage = "https://github.com/AmusementClub/vs-mlrt";
    license = with licenses; [ ];
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
