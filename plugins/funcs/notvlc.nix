{ lib, mkVapoursynthPythonSinglefileFunc, pkg-config,fetchPypi,libdvdread, fetchFromGitHub,buildPythonPackage, vapoursynthPlugins, python3,pythonPackages }:
let

  crudexml = buildPythonPackage rec {
    pname = "crudexml";
    version = "1.1";

    src = fetchPypi {
      pname = "crudexml";
      version = "1.0";
      sha256 = "sha256-AEboujbi11OfXmRxGdzI6HeuG0fMujmqP8J07q3/FsI=";
    };
    pythonImportsCheck = ["crudexml"];
  };

  pydvdread = buildPythonPackage rec {
    pname = "dvdread";
    version = "1.1";

    src = fetchFromGitHub {
      owner = "cmlburnett";
      repo = "PyDvdRead";
      rev  = "9b82bd08b7803710770ea3341c9b8db09d5eab3d";
      sha256 = "sha256-+6wakFluSukabGTw4+MhLmxbl63Ore5IRgnow4gHxgY=";
    };

    postPatch = ''
    substituteInPlace setup.py --replace "/usr/include" "${libdvdread}/include"
    '';

    propagatedBuildInputs = [ crudexml ];

    buildInputs = [ libdvdread ];
  };
in
mkVapoursynthPythonSinglefileFunc rec {
  pname = "notvlc";
  version = "unstable-2022-12-25";
  importname = "notvlc";

  src = fetchFromGitHub {
    owner = "po5";
    repo = pname;
    rev = "44ffe6824b25f0dd8626775fc51c7a9e7a7df87a";
    sha256 = "sha256-gehUS0Zdfaup3Lw3vwwMv/LgynBL+/Werd03yHuhTfQ=";
  };

  propagatedBuildInputs = [ pydvdread ];

  vs_binarydeps = with vapoursynthPlugins; [
    imwri
    removegrain
    mvtools
    tivtc
    average
  ];

  vs_pythondeps = with vapoursynthPlugins; [
    lvsfunc
    kagefunc
    vsutil
  ];

  meta = with lib; {
    description = "Extremely cool utilities to deal with *objective* source issues that have one clear solution ";
    homepage = "https://github.com/po5/notvlc";
    license = licenses.unfree;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
