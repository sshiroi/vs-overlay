{ lib, stdenv, fetchFromGitHub, pkg-config, autoreconfHook, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-histogram";
  version = "unstable-2022-11-27";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "c4861d63d496fa0eb873a6f949937be8c9c1dc13";
    sha256 = "sha256-0oSIHnzFfnuKMZA6jPSeyV2ekRlbJOnTyxzi2B9DF0k=";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config autoreconfHook ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "hist";

  meta = with lib; {
    description = "Histogram plugin for VapourSynth";
    homepage = "https://github.com/dubhater/vapoursynth-histogram";
    license = licenses.gpl2Plus; # https://github.com/dubhater/vapoursynth-histogram/issues/2
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
