{ lib, buildPythonPackage, fetchFromGitHub, pyqt5 }:

buildPythonPackage rec {
  pname = "PyQt5-stubs";
  version = "unstable-2022-09-08";

  src = fetchFromGitHub {
    owner = "python-qt-tools";
    repo = "PyQt5-stubs";
    rev = "35a6af908262cbf91cfa681cfb1cd4c6896caf2e";
    sha256 = "sha256-jtt/EndPsXMYpveEnUDRGKgusX+x9hLU/5brVHAgd6I=";
  };

  buildInputs = [ pyqt5 ];
  testPhase = "";

  meta = with lib; {
    description = "Python library for stubs of the PyQt5 framework";
    homepage = "https://github.com/python-qt-tools/PyQt5-stubs";
    license = licenses.gpl3;
    maintainers = with maintainers; [  ];
  };
}
