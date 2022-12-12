{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-TTempSmooth";
  version = "4.1";

  src = fetchFromGitHub {
    owner = "HomeOfVapourSynthEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-T+QudM6FUKLkEEwPiHVkDXTkS1SKB/QnWf3cMx85dUA=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
      substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_variable(pkgconfig: 'libdir')" "get_option('libdir')"
      substituteInPlace meson.build \
          --replace "b_lto=true" "b_lto=false"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "ttmpsm";

  meta = with lib; {
    description = "A TTempSmooth filter plugin for VapourSynth";
    homepage = "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TTempSmooth";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
