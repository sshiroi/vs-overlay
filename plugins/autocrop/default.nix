{ lib, stdenv, fetchFromGitHub, vapoursynth }:

let
  ext = stdenv.targetPlatform.extensions.sharedLibrary;
in stdenv.mkDerivation rec {
  pname = "vapoursynth-autocrop";
  #version = "0.1";
  version = "unstable-2022-12-11";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
  #  rev = version;
  #  sha256 = "15ph5w78d0p56n6x5ys24a1n0xs1bd1fbc783349px1l8606h1ac";
    rev = "418189c36adf96e14e76072c0b80548f8f9f8ebe";
    sha256 = "sha256-tzIMc46Tls5kBXBrsNAwmc5GMFpnuq4/1ISDbciCyQ0=";
  };

  buildInputs = [ vapoursynth ];

  buildPhase = ''
    c++ -std=c++11 -shared -fPIC -O2 -I${vapoursynth}/include/vapoursynth \
        autocrop.cpp -o libautocrop${ext}
  '';

  installPhase = ''
    install -D libautocrop${ext} $out/lib/vapoursynth/libautocrop${ext}
  '';

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "acrop";

  meta = with lib; {
    description = "Autocrop for VapourSynth";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vapoursynth-autocrop";
    license = licenses.unfree; # no license
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.all;
  };
}
