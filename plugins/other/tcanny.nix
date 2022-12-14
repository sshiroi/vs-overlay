{ lib, clangStdenv,stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth, boost, opencl-headers, ocl-icd }:

clangStdenv.mkDerivation rec {
  pname = "VapourSynth-TCanny";
  version = "14";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-UUYb9UFZ3oB05hAW/FvvM0a8nyJlQnynZSSajF2l/U0=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth boost opencl-headers ocl-icd ];

  # https://github.com/NixOS/nixpkgs/issues/86131
  BOOST_INCLUDEDIR = "${lib.getDev boost}/include";
  BOOST_LIBRARYDIR = "${lib.getLib boost}/lib";

  postPatch = ''
      substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"

      substituteInPlace meson.build \
          --replace "b_lto=true" "b_lto=false"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "tcanny";

  meta = with lib; {
    description = "TCanny filter for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TCanny";
    license = licenses.gpl2;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
