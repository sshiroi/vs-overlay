{ lib, stdenv, fetchFromGitHub, pkg-config, vapoursynth, vapoursynthPlugins, qtbase, qttools, wrapQtAppsHook, autoreconfHook }:
stdenv.mkDerivation rec {
  name = "Wobbly";
  version = "unstable-2022-09-21";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = name;
    rev = "11720c946d15fcf3afb83c03b8cc7e76d78b515a";
    sha256 = "sha256-1uWl4rxF7qumSdaE9Ok7wa39mxbpJErHSmJc3m2bGSs=";
  };

  patches = [
    ./patch.patch
  ];

  nativeBuildInputs = [ pkg-config wrapQtAppsHook autoreconfHook qttools ];
  buildInputs = [  (vapoursynth.withPlugins (with vapoursynthPlugins; [  d2vsource lsmashsource vivtc scxvid fieldhint tdeintmod ])) ];

  meta = with lib; {
    description = "Wobbly can be used to filter a video per scene";
    homepage = "https://github.com/dubhater/Wobbly";
    license = licenses.unfree; # no license
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}