{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, ffmpeg, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "d2vsource";
  version = "1.2";

  #master has v4 api
  src = fetchFromGitHub {
    owner = "dwbuiten";
    repo = pname;
    rev = "v${version}";
    sha256 = "1ax20qs1hba70r07pdw3gs4gylwb2ca4iz9ycmd9i5rvxaxy4hmp";
  };

  configureFlags = [ "--libdir=$(out)/lib/vapoursynth" ];

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ ffmpeg vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "d2v";

  meta = with lib; {
    description = "D2V parser and decoder for VapourSynth";
    homepage = "https://github.com/dwbuiten/d2vsource";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ sbruder ];
    platforms = platforms.all;
  };
}
