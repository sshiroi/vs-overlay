{ lib, buildPythonPackage, fetchFromGitHub, setuptools, flit-core, vapoursynth }:

buildPythonPackage rec {
  pname = "vs-engine";
  version = "master";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "Irrational-Encoding-Wizardry";
    repo = "vs-engine";
    rev = "ddbb6284d4556c623c144f4a402e2665dccb0338";
    sha256 = "sha256-XFI7htJQAPqUmZHx1fRYDhXuby/OmoYqlPO1zvPS9R8=";
  };

  buildInputs = [ flit-core vapoursynth ];

  postPatch = ''
    substituteInPlace pyproject.toml \
        --replace "vapoursynth>=57" "" \
  '';

  meta = with lib; {
    description = "An engine for vapoursynth previewers, renderers and script analyis tools.";
    homepage = "https://github.com/Irrational-Encoding-Wizardry/vs-engine/";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}
