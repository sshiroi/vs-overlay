{ lib, stdenv, fetchFromGitHub, wafHook, python3, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "flash3kyuu_deband";
  version = "unstable-2022-12-12";

  src = fetchFromGitHub {
    owner = "SAPikachu";
    repo = pname;
    rev = "54ff2b0c244bd3a7ecd9aa25d845f5cd739b4e20";
    sha256 = "sha256-5/tGikqaTE8T4UC0qcGKXv6i+3PnjEa83AS3DASeHtU=";
  };

  wafConfigureFlags = [ "--libdir=${placeholder "out"}/lib/vapoursynth" ];

  nativeBuildInputs = [ wafHook python3 ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "f3kdb";

  meta = with lib; {
    description = "A deband library and filter for AviSynth/VapourSynth";
    homepage = "https://github.com/SAPikachu/flash3kyuu_deband";
    license = licenses.gpl3;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
