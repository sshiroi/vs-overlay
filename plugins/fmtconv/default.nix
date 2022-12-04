{ lib, stdenv, fetchFromGitHub, autoreconfHook, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "fmtconv";
  version = "30";

  src = fetchFromGitHub {
    owner = "EleonoreMizo";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-G4foN3toSSq4objbdiFpc+0ZxjF7VNQhyyixnJj6Gkw=";
  };

  preAutoreconf = "cd build/unix";

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "fmtc";

  meta = with lib; {
    description = "Format conversion tools for VapourSynth";
    homepage = "https://github.com/EleonoreMizo/fmtconv";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
