{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
let
  python = vapoursynth.python3;
in
# required to make python.buildEnv use descale’s python module
python.pkgs.toPythonModule (stdenv.mkDerivation rec {
  pname = "vs-ccd";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "End-of-Eternity";
    repo = pname;
    rev = "4256058f08786cdac9585e803c75453a18a7878e";
    sha256 = "sha256-R/9cWYzmbruZQe/uSQk+6stOmPb5k6QDG79uwBv1v6c=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];


  postInstall = ''
    install -D ../ccd.py $out/${python.sitePackages}/ccd.py
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "ccd";

  meta = with lib; {
    description = "VapourSynth plugin to undo upscaling";
    homepage = "https://github.com/End-of-Eternity/vs-ccd";
    license = licenses.gpl3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
})
