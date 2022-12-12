{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "vapoursynth-tcomb";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "29318d2b9b5e2f266202294498533805f48b194f";
    sha256 ="sha256-uUuSlmVQ6QKGT9KMFxgNgxAhRSDVjcGxfbV65bss2oM=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "tcomb";

  meta = with lib; {
    description = "Temporal comb filter; Dotcrawl and rainbow remover";
    homepage = "https://github.com/dubhater/vapoursynth-tcomb";
    license = licenses.lgpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
