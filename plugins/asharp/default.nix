{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "vapoursynth-asharp";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-mxeJ+7qFbjgWTE/bC+Ue0Q4EdfTvVoU9X739kgj1TVQ=";
  };

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "asharp";

  meta = with lib; {
    description = "adaptive sharpening filter";
    homepage = "https://github.com/dubhater/vapoursynth-asharp";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
