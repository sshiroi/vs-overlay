{ lib, stdenv, fetchFromGitHub, meson, cmake, ninja, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "Vapoursynth-VFRToCFR";
  version = "unstable-2022-11-27";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = pname;
    rev = "d00a3743db70b928f3b0529d54f21aeae93d9db8";
    sha256 = "sha256-sXJ1vMPp5EYA1UVqZprTLSrtOcMF8pgX5hDgscBg/rg=";
  };

  mesonFlags = [ "--libdir=${placeholder "out"}/lib" ];

  nativeBuildInputs = [ meson cmake ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "vfrtocfr";

  meta = with lib; {
    description = "Converts Variable Frame Rate (VFR) video to a Constant Frame Rate (CFR) video through the use of Matroska Version 2 Timecodes.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-VFRToCFR";
    license = licenses.bsd3;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
