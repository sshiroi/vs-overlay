{ lib, stdenv, fetchFromGitHub,  vapoursynth, pkg-config, autoreconfHook }:

stdenv.mkDerivation rec {
  name = "vapoursynth-fieldhint";
  version = "3";

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ vapoursynth ];

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = name;
    rev = "v${version}";
    sha256 = "sha256-c0/59NQDINM1WnkcUMB6ItxgRA+OV5dEn6BxFG7UQmg=";
  };

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "fh";

  meta = with lib; {
    description = "FieldHint creates new frames by copying the top and bottom fields from arbitrary frames chosen by the user.";
    homepage = "https://github.com/dubhater/vapoursynth-fieldhint";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}