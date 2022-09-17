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
    rev = "65f960692b480e10cd75c252cc4bff92854ab2fe";
    sha256 = "sha256-y061iLdDHwCwxM8V7H8fYoWPCydhGj7XuOkFLj16hLE=";
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
