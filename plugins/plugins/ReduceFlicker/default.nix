{ lib, stdenv, fetchFromGitHub, autoreconfHook, pkg-config, which, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "VapourSynth-ReduceFlicker";
  version = "unstable-2022-12-11";

  src = fetchFromGitHub {
    owner = "VFR-maniac";
    repo = pname;
    rev = "8766391ceeb2540d10a75550f09cdf6821392a69";
    sha256 = "sha256-RyuHdufF/TV1n96HOae7o+c6YHQ3uF5NHF3vjSePrng=";
  };


  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [ vapoursynth ];

  configureFlags = [ "--libdir=$(out)/lib" ];

  postUnpack = ''
    patchShebangs .
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "reduceflicker";

  meta = with lib; {
    description = "ReduceFlicker";
    homepage = "https://github.com/VFR-maniac/VapourSynth-ReduceFlicker";
    license = licenses.unfree;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
