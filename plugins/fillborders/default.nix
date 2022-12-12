{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-fillborders";
  #version = ">2";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "dubhater";
    repo = pname;
    rev = "78fe68044fe3414ce8061bf811a235e29c8f7d9d";
    sha256 = "sha256-mAeFVG9Mi7AIubRdakhJJIdRtXmT0b5YXpEWp4me6uI=";
  };

  nativeBuildInputs = [ meson ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  postInstall = ''
    # it installs the library in the wrong directory
    mkdir $out/lib/vapoursynth
    mv $out/lib/libfillborders.* $out/lib/vapoursynth/
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "fb";

  meta = with lib; {
    description = "VapourSynth plugin to fill the borders of a clip";
    homepage = "https://github.com/dubhater/vapoursynth-fillborders";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
