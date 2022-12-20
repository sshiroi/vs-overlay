{ lib, fetchFromGitHub, mkVapoursynthMesonB, llvmPackages_13, libxml2 }:

mkVapoursynthMesonB rec {
  pname = "akarin";
  version = "0.96";
  namespace = "akarin";

  src = fetchFromGitHub {
    owner = "AkarinVS";
    repo = "vapoursynth-plugin";
    rev = "v${version}";
    sha256 = "sha256-bpm67iA2rHVPcIZNEcsPpfHxxAvmPPhr1iMcMAvbLjU=";
  };

  mesonFlags = [ "-Dstatic-llvm=false" ];

  buildInputs = [ llvmPackages_13.llvm libxml2 ];

  meta = with lib; {
    description = "AkarinVS's vapoursynth-plugin";
    homepage = "https://github.com/AkarinVS/vapoursynth-plugin";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
