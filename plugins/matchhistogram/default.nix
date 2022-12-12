{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:
stdenv.mkDerivation rec {
  pname = "vapoursynth-matchhistogram";
  version = "2";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "v${version}";
    sha256 ="sha256-ee9vIEpZlCI8qzRLGfOU92jknOVJy4AcoV/XxkrFEsI=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  mesonFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "matchhist";

  meta = with lib; {
    description = "MatchHistogram modifies one clip's histogram to match the histogram of another clip.";
    homepage = "https://github.com/dubhater/vapoursynth-matchhistogram";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
