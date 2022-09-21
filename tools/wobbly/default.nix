{ lib, stdenv, fetchFromGitHub, pkg-config, vapoursynth, vapoursynthPlugins, qtbase, qttools, wrapQtAppsHook, autoreconfHook }:
stdenv.mkDerivation rec {
  name = "Wobbly";
  version = "unstable-2022-09-21";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = name;
    rev = "730e15f806817ecd0d5c7bf07d14949a2ba1881c";
    sha256 = "sha256-JmfNOPUGvmyet8W6rotwxhE9sSvajQWzOE3O4CnZuPI=";
  };

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