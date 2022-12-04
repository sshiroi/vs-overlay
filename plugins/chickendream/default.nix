{ lib, stdenv, fetchFromGitHub, pkg-config, which, vapoursynth, autoreconfHook }:

stdenv.mkDerivation {
  pname = "chickendream";
  version = "2";

  src = fetchFromGitHub {
    owner = "EleonoreMizo";
    repo = "chickendream";
    rev = "r2";
    sha256 = "sha256-YnrqVS8KBWekWA/w4zJT2jW0OV1+/f/sbZyk5xQ7HkI=";
  };

  preAutoreconf = "cd build/unix";
  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ pkg-config which autoreconfHook ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "chkdr";

  meta = with lib; {
    description = "realistic film grain";
    homepage = "https://github.com/EleonoreMizo/chickendream";
    license = with licenses; [ wtfpl ];
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
