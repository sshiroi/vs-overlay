{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA, mkVapoursynthPythonSinglefileFunc, meson, ninja, pkg-config, vapoursynth }:
let
  python = vapoursynth.python3;


  src = fetchFromGitHub {
    owner = "End-of-Eternity";
    repo = "vs-ccd";
    rev = "4256058f08786cdac9585e803c75453a18a7878e";
    sha256 = "sha256-R/9cWYzmbruZQe/uSQk+6stOmPb5k6QDG79uwBv1v6c=";
  };

  meta = with lib; {
    description = "VapourSynth plugin to undo upscaling";
    homepage = "https://github.com/End-of-Eternity/vs-ccd";
    license = licenses.gpl3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };

  native_module  = mkVapoursynthMesonA {
    pname = "vs-ccd-python";
    version = "unstable-2022-12-12";
    namespace = "ccd";

    inherit meta src;
  };

  python_module = mkVapoursynthPythonSinglefileFunc rec {
    pname = "vs-ccd-python";
    version = "unstable-2022-12-12";
    importname = "ccd";

    inherit src meta;

    vs_binarydeps = [ native_module ];
    vs_pythondeps = [ ];
  };
in
  python_module