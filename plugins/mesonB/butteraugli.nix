{ lib,  fetchFromGitHub,  mkVapoursynthMesonB }:

mkVapoursynthMesonB rec {
  pname = "VapourSynth-butteraugli";
  version = "2";
  namespace = "butteraugli";

  src = fetchFromGitHub {
    owner = "fdar0536";
    repo = pname;
    rev = "r${version}";
    sha256 = "sha256-oTnCj2ryqpS/V8v+I/r//4qPNeRxrWvFC5ckxB4wluQ=";
    fetchSubmodules = true;
  };

  buildInputs = [ ];

  meta = with lib; {
    description = "A tool for measuring perceived differences between images";
    homepage = "https://github.com/fdar0536/VapourSynth-butteraugli";
    license = licenses.unfree; #apache2
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
