{ lib, stdenv, fetchFromGitHub, meson, ninja, pkg-config, ffmpeg, vapoursynth, jansson, cmake }:
let
 libp2p = fetchFromGitHub {
    owner = "sekrit-twc";
    repo = "libp2p";
    rev = "5e65679ae54d0f9fa412ab36289eb2255e341625";
    sha256 = "sha256-DEl2YmcPmXF7ND0CGgUDOgnLzLhuW6RpKK4flqJ4r6g=";
  };
in
stdenv.mkDerivation rec {
  pname = "bestsource";
  version = "unstable-2022-09-17";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "ba1249c1f5443be6d0ec2be32490af5bbc96bf99";
    sha256 = "sha256-9BnyRzF33otju3W503O18JuTyvp+hFxk6JMwrozKoZY=";
  };
  postUnpack = ''
  cp -r ${libp2p} source/libp2p
  '';

  nativeBuildInputs = [ meson cmake ninja pkg-config ];
  buildInputs = [ ffmpeg vapoursynth jansson ];

  postPatch = ''
    substituteInPlace meson.build \
        --replace "vapoursynth_dep.get_pkgconfig_variable('libdir')" "get_option('libdir')"
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "bs";


  meta = with lib; {
    description = "Cross-platform wrapper library around FFmpeg";
    homepage = "https://github.com/vapoursynth/bestsource";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
