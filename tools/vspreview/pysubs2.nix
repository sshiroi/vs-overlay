{ lib, buildPythonPackage, pytest, fetchFromGitHub }:

buildPythonPackage rec {
  pname = "pysubs2";
  version = "1.4.2";

  src = fetchFromGitHub {
    owner = "tkarabela";
    repo = "pysubs2";
    rev = "1.4.2";
    sha256 = "sha256-uhqj2TrO7bLML+SQXIf71f5GKGf7uHkxvoSn6mNu1Xc=";
  };
  buildInputs = [ pytest ];

  meta = with lib; {
    description = "pysubs2 is a Python library for editing subtitle files";
    homepage = "https://github.com/tkarabela/pysubs2";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}