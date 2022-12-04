{ lib, stdenv, fetchFromGitHub, meson, pkg-config, ninja, vapoursynth, llvmPackages_13, libxml2 }:

stdenv.mkDerivation rec {
  pname = "akarin";
  version = "0.96";

  src = fetchFromGitHub {
    owner = "AkarinVS";
    repo = "vapoursynth-plugin";
    rev = "v${version}";
     sha256 = "sha256-bpm67iA2rHVPcIZNEcsPpfHxxAvmPPhr1iMcMAvbLjU=";
  };

  nativeBuildInputs = [ meson pkg-config ninja ];
  buildInputs = [ vapoursynth llvmPackages_13.llvm libxml2 ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "akarin";

  meta = with lib; {
    description = "AkarinVS's vapoursynth-plugin";
    homepage = "https://github.com/AkarinVS/vapoursynth-plugin";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
