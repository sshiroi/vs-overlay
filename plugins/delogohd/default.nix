{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "DelogoHD";
  version = "12";

  src = fetchFromGitHub {
    owner = "HomeOfAviSynthPlusEvolution";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-SfhVC+pLpO4Kapp7Opes1l5SpLSHkkmU53SCxznzfCc=";
  };

  patches = [ ./build_patch.patch ];

  nativeBuildInputs = [ pkg-config cmake ];
  buildInputs = [ vapoursynth ];

  doInstallCheck = true;
  installCheckPhase = vapoursynth.installCheckPhasePluginExistanceCheck vapoursynth "delogohd";

  meta = with lib; {
    description = "Overhauled of the original delogo filter";
    homepage = "https://github.com/HomeOfAviSynthPlusEvolution/DelogoHD";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
