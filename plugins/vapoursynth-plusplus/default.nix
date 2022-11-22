#this is a regular library not a vapoursynth plugin
{ lib, stdenv, fetchFromGitHub, meson, ninja, cmake, pkg-config, fftwFloat, vapoursynth }:

stdenv.mkDerivation rec {
  pname = "vapoursynth-plusplus";
  version = "stable-2022-10-15";

  src = fetchFromGitHub {
    owner = "IFeelBloated";
    repo = pname;
    rev = "fc6f2fc53e2eb1e041d837e84dc2ce7e82774188";
    sha256 = "sha256-xatZsa+3b2P3ubeUfViDBRhjFroLvu/ciyxqI1tBZ64=";
    #rev = "944adacb61e111234da61a471d6481f929e6dc8d";
    #sha256 = "sha256-0Qb3Yabb4wf3WSSLvPQkkJfZ9+npPodIWmg0ke/OiMU=";
  };

  nativeBuildInputs = [ meson cmake ninja pkg-config ];
  buildInputs = [ vapoursynth ];

  meta = with lib; {
    description = "Vaporsynth C++ API";
    homepage = "https://github.com/IFeelBloated/vapoursynth-plusplus";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
