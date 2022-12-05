{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
let
  python = vapoursynth.python3;
in
# required to make python.buildEnv use descale’s python module
python.pkgs.toPythonModule (stdenv.mkDerivation rec {
  pname = "vapoursynth-descale";
  version = "8";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-dobooNxoDH1MBQtycfiZTE3xy7j5fCGhD9cnPGGZocc=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vs.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  postInstall = ''
    install -D ../descale.py $out/${python.sitePackages}/descale.py
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "descale";

  meta = with lib; {
    description = "VapourSynth plugin to undo upscaling";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder tadeokondrak ];
    platforms = platforms.all;
  };
})
