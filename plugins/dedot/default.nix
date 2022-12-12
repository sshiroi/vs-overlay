{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "vapoursynth-dedot";
  version = "1";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 ="sha256-MTd4fCTyiVYElEevfDU4EDLmW5qCEVEQK3wr+vfkEv8=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "dedot";

  meta = with lib; {
    description = "Dedot is a temporal cross color";
    homepage = "https://github.com/dubhater/vapoursynth-dedot";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
