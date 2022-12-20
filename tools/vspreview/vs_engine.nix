{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, flit-core
, vapoursynth
}:

buildPythonPackage rec {
  pname = "vs-engine";
  version = "master";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = "vs-engine";
    rev = "ddbb6284d4556c623c144f4a402e2665dccb0338";
    sha256 = "sha256-XFI7htJQAPqUmZHx1fRYDhXuby/OmoYqlPO1zvPS9R8=";
  };

  format = "pyproject";
  buildInputs = [  flit-core vapoursynth ];

  postPatch = ''
    substituteInPlace pyproject.toml \
        --replace "vapoursynth>=57" "" \
  '';

  meta = with lib; {
    description = "pysubs2 is a Python library for editing subtitle files";
    homepage = "https://github.com/tkarabela/pysubs2";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}
