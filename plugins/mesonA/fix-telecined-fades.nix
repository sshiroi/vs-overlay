{ lib, stdenv, fetchFromGitHub, mkVapoursynthMesonA, cmake, yasm }:

mkVapoursynthMesonA rec {
  pname = "fix-telecined-fades";
  version = "unstable-2022-11-27";
  namespace = "ftf";
  install_dir_vapoursynth_added_in_meson = true;

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "e70d7fb759cf0109c8ed74a446c94124aa6b1201";
    sha256 = "sha256-VJh0HIqYSwswYjSfJcJUGWPAIs/M2yZG2T7bQZCzx70=";
  };

  nativeBuildInputs = [ cmake  ];
  buildInputs = [  yasm ];

  meta = with lib; {
    description = "Solution for when fades were done AFTER telecine which made a picture perfect IVTC pretty much impossible.";
    homepage = "https://github.com/IFeelBloated/Fix-Telecined-Fades";
    license = licenses.gpl3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}