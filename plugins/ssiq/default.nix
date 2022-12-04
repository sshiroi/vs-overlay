{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, which, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-ssiq";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-IjNBcaHpHFL74EbDbQefXOOfpCMO6iGqGJ8fVwv2Trk=";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config which autoreconfHook ];
  buildInputs = [ vapoursynth ];


  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "ssiq";

  meta = with lib; {
    description = "this filter performs structure-preserving smoothing";
    homepage = "https://github.com/dubhater/vapoursynth-ssiq";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
