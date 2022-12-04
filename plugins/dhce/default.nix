{ lib, stdenv, fetchFromGitHub, cmake, vapoursynth }:
stdenv.mkDerivation rec {
  name = "VapourSynth-DehazingCE";
  version = "unstable-2022-09-21";

  src = fetchFromGitHub {
    owner = "Kiyamou";
    repo = name;
    rev = "ea3ff7ab6a05f9d64be9edbe296259b7f7bd3e04";
    sha256 = "sha256-dWM2iRDWds27+47tskdSWOmNOLMIGsLHdLYXia4Fchc=";
  };

  nativeBuildInputs = [ cmake vapoursynth ];

  cmakeFlags = [
    "-DVAPOURSYNTH_INCLUDE_DIR=${vapoursynth}/include"
  ];

  installPhase = ''
  mkdir -p $out/lib/vapoursynth
  cp libDehazingCE.so $out/lib/vapoursynth
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "dhce";

  meta = with lib; {
    description = "Dehazing plugin for VapourSynth, based on contrast enhancement.";
    homepage = "https://github.com/Kiyamou/VapourSynth-DehazingCE";
    license = licenses.unfree;# dunno whats the license
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}