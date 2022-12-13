{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-Bwdif";
  version = "4.1";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = "${pname}";
    rev = "r${version}";
    sha256 = "sha256-wpALZMSKX+LvbPOL1DpqumfT1Ql4Kbi4Mi7U2nooZmQ=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth  ];

  postPatch = ''
      substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"
      substituteInPlace meson.build \
          --replace "b_lto=true" "b_lto=false"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "bwdif";

  meta = with lib; {
    description = "Motion adaptive deinterlacing based on yadif";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Bwdif";
    license = licenses.gpl2;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
