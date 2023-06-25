{ lib, fetchFromGitHub, mkVapoursynthMesonB, ffmpeg_4, jansson, cmake }:
let
 libp2p = fetchFromGitHub {
    owner = "sekrit-twc";
    repo = "libp2p";
    rev = "5e65679ae54d0f9fa412ab36289eb2255e341625";
    sha256 = "sha256-DEl2YmcPmXF7ND0CGgUDOgnLzLhuW6RpKK4flqJ4r6g=";
  };
in
mkVapoursynthMesonB rec {
  pname = "bestsource";
  version = "unstable-2022-09-17";
  namespace = "bs";

  src = fetchFromGitHub {
    owner = "vapoursynth";
    repo = pname;
    rev = "ba1249c1f5443be6d0ec2be32490af5bbc96bf99";
    sha256 = "sha256-9BnyRzF33otju3W503O18JuTyvp+hFxk6JMwrozKoZY=";
  };

  postUnpack = ''
  cp -r ${libp2p} source/libp2p
  '';

  nativeBuildInputs = [ cmake ];
  buildInputs = [ ffmpeg_4 jansson ];

  meta = with lib; {
    description = "Cross-platform wrapper library around FFmpeg";
    homepage = "https://github.com/vapoursynth/bestsource";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
