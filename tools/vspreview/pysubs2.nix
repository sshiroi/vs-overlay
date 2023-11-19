{ lib, buildPythonPackage, pytest, fetchFromGitHub }:

buildPythonPackage rec {
  pname = "pysubs2";
  version = "1.6.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "tkarabela";
    repo = "pysubs2";
    rev = "f83b8180b8fede6320ac3bca1c9b6b98ef6b7bff";
    sha256 = "sha256-0bW9aB6ERRQK3psqeU0Siyi/8drEGisAp8UtTfOKlp0=";
  };
  nativeBuildInputs = [ pytest ];

  meta = with lib; {
    description = "pysubs2 is a Python library for editing subtitle files";
    homepage = "https://github.com/tkarabela/pysubs2";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}