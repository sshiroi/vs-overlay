{ lib, stdenv, fetchFromGitHub, callPackage, mkVapoursynthMesonB, mkVapoursynthPythonSinglefileFunc, meson, ninja, pkg-config, vapoursynth }:
let
  python = vapoursynth.python3;

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = "vapoursynth-descale";
    rev = "r8";
    sha256 = "sha256-dobooNxoDH1MBQtycfiZTE3xy7j5fCGhD9cnPGGZocc=";
  };

  meta = with lib; {
    description = "VapourSynth plugin to undo upscaling";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder tadeokondrak ];
    platforms = platforms.all;
  };

  native_module = mkVapoursynthMesonB rec {
    inherit src meta;

    pname = "vapoursynth-descale-binary";
    version = "8";
    namespace = "descale";

    modeb_replace = "vs.get_pkgconfig_variable('libdir')";
  };

  python_module = mkVapoursynthPythonSinglefileFunc rec {
    pname = "vapoursynth-descale-python";
    version = "8";
    importname = "descale";

    vs_binarydeps = [ native_module ];
    vs_pythondeps = [ ];

    inherit src meta;
  };
in
  python_module