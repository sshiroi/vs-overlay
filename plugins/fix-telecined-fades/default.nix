{ lib, stdenv, fetchFromGitHub, meson, cmake, ninja, pkg-config, vapoursynth, yasm }:

stdenv.mkDerivation rec {
  pname = "fix-telecined-fades";
  version = "unstable-2022-11-27";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "e70d7fb759cf0109c8ed74a446c94124aa6b1201";
    sha256 = "sha256-VJh0HIqYSwswYjSfJcJUGWPAIs/M2yZG2T7bQZCzx70=";
  };

  mesonFlags = [ " --libdir=${placeholder "out"}/lib" ];

  nativeBuildInputs = [ meson cmake ninja pkg-config ];
  buildInputs = [ vapoursynth yasm ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "ftf";

  meta = with lib; {
    description = "Solution for when fades were done AFTER telecine which made a picture perfect IVTC pretty much impossible.";
    homepage = "https://github.com/IFeelBloated/Fix-Telecined-Fades";
    license = licenses.gpl3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
